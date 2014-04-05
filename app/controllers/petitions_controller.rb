class PetitionsController < ApplicationController
  before_action :set_petition, only: [:show, :edit, :update, :destroy]

  # GET /petitions
  # GET /petitions.json
  def index
    #@petitions = Petition.all
    @petition = Petition.find_by(temp_id: 4)
    session[:referal_url] = request.referrer
    @user = User.new
    @petition_counter = @petition.users.count + 512

    render locale == :en ? "show" : "show_fr"
  end

  # GET /petitions/1
  # GET /petitions/1.json
  def show
    session[:referal_url] = request.referrer
    @user = User.new
    @petition_counter = @petition.users.count + 512

  end

  # GET /petitions/new
  def new
    @petition = Petition.new
  end

  def add_user
    @success = false
    @petition = Petition.where(temp_id: 4).first
    @user = User.where(email: params[:email]).first #current_user

    if @user.nil?
      user = User.new(user_params)
      user.skip_confirmation!
    end

    user.referal_url = session[:referal_url]
    user.petitions.push(@petition)
    @success = user.save!(validate: false)
    respond_to do |format|
      format.js
      #thank_you.js
    end

  end

  # GET /petitions/1/edit
  def edit
  end

  # POST /petitions
  # POST /petitions.json
  def create
    @petition = Petition.new(petition_params)

    respond_to do |format|
      if @petition.save
        format.html { redirect_to @petition, notice: 'Petition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @petition }
      else
        format.html { render action: 'new' }
        format.json { render json: @petition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /petitions/1
  # PATCH/PUT /petitions/1.json
  def update
    respond_to do |format|
      if @petition.update(petition_params)
        format.html { redirect_to @petition, notice: 'Petition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @petition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /petitions/1
  # DELETE /petitions/1.json
  def destroy
    @petition.destroy
    respond_to do |format|
      format.html { redirect_to petitions_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_petition
    @petition = Petition.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def petition_params
    params.require(:petition).permit(:title, :description)
  end

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :address, :postal_code, :city, :phone_number, :birthday)
  end
end