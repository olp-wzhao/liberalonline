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
    #if the document doesn't exist how do I pass the parameters
    @attachment = Attachment.new(attachment_params)
    valid = @attachment.valid?
    if valid
      @document = Document.find params[:document_id]
      @document.attachments << @attachment
      valid = @document.save
    end

    if valid
      if request.xhr? || remotipart_submitted?
        render :layout => false, :template => '/admin/attachments/create.js', :status => :ok, :format => :js
      end
      #format.js #redirect_to edit_admin_document_path(@document) }
      #format.json { render json: 'attachment saved to mongodb', status: :created }
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
        format.js
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