class LawnsignRequestsController < ApplicationController
  before_action :set_lawnsign_request, only: [:show, :edit, :update, :destroy]

  layout 'inside_layout'

  # GET /lawnsign_requests
  # GET /lawnsign_requests.json
  def index
    @lawnsign_requests = LawnsignRequest.all
  end

  # GET /lawnsign_requests/1
  # GET /lawnsign_requests/1.json
  def show
  end

  # GET /lawnsign_requests/new
  def new
    @lawnsign_request = LawnsignRequest.new
  end

  # GET /lawnsign_requests/1/edit
  def edit
  end

  # POST /lawnsign_requests
  # POST /lawnsign_requests.json
  def create
    @lawnsign_request = LawnsignRequest.new(lawnsign_request_params)
    
    if current_user.nil?
      #create a new user and send a confirmation email to the user
      user = User.create(email: lawnsign_request_params[:email])
    end

    respond_to do |format|
      if @lawnsign_request.save
        format.html { redirect_to root_url, notice: 'Lawnsign request was successfully created.' }
        format.json { render json: @lawnsign_request, status: :created, location: @lawnsign_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @lawnsign_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lawnsign_requests/1
  # PATCH/PUT /lawnsign_requests/1.json
  def update
    respond_to do |format|
      if @lawnsign_request.update(lawnsign_request_params)
        format.html { redirect_to @lawnsign_request, notice: 'Lawnsign request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lawnsign_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lawnsign_requests/1
  # DELETE /lawnsign_requests/1.json
  def destroy
    @lawnsign_request.destroy
    respond_to do |format|
      format.html { redirect_to lawnsign_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lawnsign_request
      @lawnsign_request = LawnsignRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def lawnsign_request_params
      #params[:volunteer]
      params.require(:lawnsign_request).permit(:sign_size_large, :message, :user)
    end
end
