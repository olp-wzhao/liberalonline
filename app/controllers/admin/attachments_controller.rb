class Admin::AttachmentsController < Admin::AdminController
  before_filter :authenticate_admin!

  def new
    @document = Document.find_or_create_by(id: params[:document_id])
    @attachment = Attachment.new
    respond_to do |format|
      format.js
    end
  end

  def index
    @attachments = Attachment.all
    @attachment = Attachment.new
  end

  def show
    respond_to do |format|
      format.js {}
    end
  end

  def create
    # if !attachment_params["temp_id"].nil?
    #   @attachment = Attachment.find_or_create_by(temp_id: attachment_params["temp_id"])
    # else
    #   @attachment = Attachment.where(id: attachment_params["id"]).first
    #   if @attachment.nil?
    @document = Document.find_by(id: params[:document_id])
    @attachment = Attachment.new(attachment_params)
    @document.attachments << @attachment
    #   end
    # end
    
    #@attachment.update(attachment_params)
    respond_to do |format|
      if @document.save
        format.js
        format.html { redirect_to edit_admin_document_path(@document) }
        #format.json { render json: 'attachment saved to mongodb', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment = Attachment.where(id: params["id"])
    @deleted_attachment_id = @attachment.first.id
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.js
    end
  end

  private
   def attachment_params
      params.require(:attachment).permit(
        :icon_uri,
        :language, 
        :upload_date, 
        :title, 
        :description, 
        :place, 
        :database_name,
        :file_location,
        :attachment_type,
        :published,
        :web_site,
        :updated_time,
        :temp_id,
        :pdf,
        :pdf_cache)
    end
end