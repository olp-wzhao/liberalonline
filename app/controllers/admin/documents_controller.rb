class Admin::DocumentsController < Admin::AdminController

  #before_filter :authenticate_user!, :except => [:show, :index, :toolkit, :toolkit_show]
  before_filter :authenticate_admin! #, :only => [:toolkit, :toolkit_show]
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  #respond_to :html, :json

  # GET /documents
  # GET /documents.json
  def index
    search_params
    @documents = @documents.order_by(:updated_at.desc).limit(10)
  end

  # GET /documents/new
  def new
    @document = Document.new
    @attachment = Attachment.new
    render :layout => "admin"
  end

  # GET /documents/1/edit
  def edit
    @attachment = Attachment.new
    render :layout => "admin"
  end

  # POST /documents
  # POST /documents.json
  def create
    success = false
    # API calls need to use temp_id, perhaps they should be in an API controller
    @document = Document.where(id: document_params['id']).first
    if !@document.nil?
      success = @document.update(document_params)
    else
      @document = Document.new(document_params)
      success = @document.save
    end

    respond_to do |format|
      if success
        format.html { redirect_to admin_documents_path, notice: 'Document was successfully created.' }
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
        format.html { redirect_to admin_document_url(@document), notice: 'Document was successfully updated.' }
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
      format.html { redirect_to admin_documents_url }
      format.json { head :no_content }
    end
  end

  #Admin routes
  def toolkit
    @documents = Document.toolkit.limit(10)
    render :layout => "toolkit_layout"
  end

  def show
      @document = Document.find params[:id]
      render :layout => "toolkit_layout"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.where(temp_id: params[:id]).first
      if @document.nil?
        @document = Document.find params[:id]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      fix_scrambled_date_parameters_on_create("display_date")
      fix_scrambled_date_parameters_on_create("expiry_date")
      fix_scrambled_date_parameters_on_create("document_date")
      params.require(:document).permit(
        :id,
        :name,
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
        :updated_at,

        #lets make this a table
        :doc_type, 
        :temp_id, 
        :category_id, 
        :customized_category_id,  
        :issue_id,
        :image,
        :image_cache)
    end

    def fix_scrambled_date_parameters_on_create(field_name)
      x,y,z = params[:document][:"#{field_name}(1i)"], params[:document][:"#{field_name}(2i)"], params[:document][:"#{field_name}(3i)"]
      params[:document][field_name] = "#{z}/#{y}/#{x}"
      params[:document].delete :"#{field_name}(1i)"
      params[:document].delete :"#{field_name}(2i)"
      params[:document].delete :"#{field_name}(3i)"
    end

  def search_params
    @documents = Document.all
    params.each do |key, value|
      # target groups using regular expressions
      skip_list = ['auth_token', 'action', 'controller', 'format', 'scope']
      unless skip_list.include?(key)
        @documents = @documents.where(key => value)
      end
    end

  end
end
