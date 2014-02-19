class AttachmentsController < ApplicationController

  def create
    success = false
    @attachment = Attachment.find_or_create_by(temp_id: attachment_params["temp_id"])
    
    logger.info "New or Updated Document: #{@attachment.attributes.inspect}"
    logger.info "attachment parameters: #{attachment_params}"
    
    if !@attachment.nil?
      @attachment = @attachment
      success = @attachment.update(attachment_params)
    else
      @attachment = Document.new(attachment_params)
      success = @attachment.save
    end

    respond_to do |format|
      if success
        logger.info "Updated @attachment"
        format.html { redirect_to @attachment, notice: 'Document was successfully created.' }
        format.json { render json: 'attachment saved to mongodb', status: :created }
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
        :temp_id
    end
end