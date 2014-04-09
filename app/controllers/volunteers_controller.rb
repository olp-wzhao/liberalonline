class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!
  include DateTimeFixes

  layout 'inside_layout'

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all
  end

  def extended

  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
  end

  # GET /volunteers/new
  def new
    @volunteer = Volunteer.new
    @user = current_user.nil? ? User.new : current_user
    current_user = @user
    current_user.volunteer = @volunteer
<<<<<<< HEAD
=======

>>>>>>> c4204348febd7bc71d4020230b5f3b05a85ca1a8
    log_stuff
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /volunteers/1/edit
  def edit
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    current_user = current_user.nil? ? User.new : current_user
    @volunteer = current_user.build_volunteer(volunteer_params)

    current_user.save!(validate: false)
    @user = current_user
    log_stuff
    success = @volunteer.save
    respond_to do |format|
      if success
        format.html { redirect_to volunteer_path(@volunteer), notice: 'Volunteer was successfully created.' }
        format.json { render json: @volunteer.id, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      #params[:volunteer]
      params.require(:volunteer).permit(:availability_weekdays, :availability_weeknights, :availability_weekends, :still_photography, :video_production, :graphic_design, :voice_acting, :set_design, :screenwriter, :web_design, :composer, :motion_graphics, :data_mining, :process_analysis, :programming, :arc_view, :excel, :email_marketing, :sql, :trained_on_libe, :canvassing, :trained_on_liberalist, :telemarketing, :campaign_manager, :digital_ad_buying, :printing, :ad_buying, :screen_printing, :accounting)
    end

    #def user_params
    #  #fix_scrambled_date_parameters
    #  params.require(:user).permit(:id, :email, :first_name, :last_name, :address, :postal_code, :city, :phone_number, :birthday)
    #end
    #
    #def build_partial_user
    #  user = User.new(user_params)
    #end

    def log_stuff
      if current_user
        logger.debug "User id: #{current_user.id}".to_s.colorize(:green)
        if current_user.volunteer
          logger.debug "Volunteer id: #{current_user.volunteer.id}".colorize(:green)
        end
      else
        logger.debug 'User is not logged in, or has lost connection'.colorize(:light_yellow)
      end
    end
end
