class DocumentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :authenticate_admin!, :only => [:toolkit]
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.news_documents.all.limit(100)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @current_document = nil
    
    begin
      @current_documents = Document.where(published: true, language: @language)
                      .between(temp_id: 0..params[:id].to_i, riding_id: -6..0)
                      .gt(expiry_date: DateTime.now)
                      .order_by(:temp_id.desc)
      @current_document = @current_documents[0]
    rescue ActiveRecord::RecordNotFound
      redirect_to '/news?l=' + @language
    end

    if @current_document == nil
      redirect_to '/error'
    else
      @current_document_photo = nil
      if @current_document.attached_photo_ids != nil && @current_document.attached_photo_ids != "" && @current_document.attached_photo_ids != "0"
        @current_document_photo = Photo.where(temp_id: @current_document.attached_photo_ids.sub(/[S]/, ' ').to_i).first
      end
      @current_document_attachments = nil
      if @current_document.attached_pdf_ids != nil && @current_document.attached_pdf_ids != ""
        attachment_ids_str = @current_document.attached_pdf_ids.split('|')
        if attachment_ids_str != nil && attachment_ids_str.length > 0
          @current_document_attachments = Array.new
          attachment_ids_str.each do |attachment_id_str|
            document_attachment = Attachment.where(temp_id: attachment_id_str.to_i).first
            if document_attachment != nil
              @current_document_attachments << document_attachment
            end
          end
        end
      end
    end 

    #@web_site_og_description = @current_document.subtitle
    #@web_site_og_title = @current_document.headline
    if @current_document_photo 
        @web_site_og_image = 'http://pantone201.ca/webskins/olp/photos/' + @current_document_photo.id.to_s + "_" + @current_document_photo.riding_id.to_s + @current_document_photo.filename + '_PhotoUp.jpg'
    else
      @web_site_og_image = 'http://www.ontarioliberal.ca/NewsBlog/media/Wynne_Headshot_Link.jpg'
    end 
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    success = false
    @document = Document.find_or_create_by(temp_id: document_params["temp_id"])
    
    logger.info "New or Updated Document: #{@document.attributes.inspect}"
    logger.info "document parameters: #{document_params}"
    if @document.any?
      @document = @document.first
      binding.pry
      success = @document.update(document_params)
    else
      @document = Document.new(document_params)
      success = @document.save
    end

    respond_to do |format|
      if success
        logger.info "Updated @document"
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render json: 'document saved to mongodb', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  #Admin routes
  def toolkit
    @documents = Document.press_release.limit(10)
    render :layout => "admin"
  end

  def toolkit_show
    if current_user.roles.include? 'webadmin'
      @document = Document.find_by(temp_id: params[:id])
      render :layout => "admin"
    else
      flash[:notice] = "You do not have authorization to view this site"
      redirect_to new_user_session_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.where(temp_id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name,
        :headline, 
        :subtitle, 
        :introduction, 
        :body, 
        :author, 
        :reference_url, 
        :reference_name, 
        :attached_photo_ids, 
        :attached_video_ids, 
        :attached_pdf_ids, 
        :petition_ids, 
        :created_date, 
        :created_ip, 
        :created_user_id, 
        :updated_ip, 
        :language, 
        :helpfulness_rating, 
        :applicability_rating, 
        :allow_comment, 
        :published, 
        :copy_protect, 
        :document_date, 
        :display_date, 
        :expiry_date, 
        :image_name, 
        :publish_on_olp, 
        :publish_on_mpp, 
        :publish_on_pla, 
        :publish_on_elect, 
        :partisan, 
        :author_photo, 
        :is_draft, 
        :riding_id, 
        :web_site, 
        :user_id, 
        :updated_time, 

        #lets make this a table
        :doctype, 
        :temp_id, 
        :category_id, 
        :customized_category_id,  
        :issue_id)
    end
end
