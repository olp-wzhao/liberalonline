class RidingAddressesController < ApplicationController
  before_action :set_riding_address, only: [:show, :edit, :update, :destroy]

  # GET /riding_addresses
  # GET /riding_addresses.json
  def index
    #@riding_addresses = RidingAddress.all
    if params[:search].present?
      @riding_locations = RidingAddress.near(params[:search], 10, :order => :distance)
      
    end
    respond_to do |format|
      begin
        if(!@riding_locations.empty?)
          #format.html # index.html.erb
          format.json { render json: {status: :success, name: @riding_locations.first.riding.title, riding_id: @riding_locations.first.riding.riding_id,
            riding_address_id: @riding_locations.first.id} }
        else
          format.json { render json: {status: :failure, name: "Central", riding_id: 9000,
            riding_address_id: nil} }
        end
      rescue Moped::Errors::QueryFailure => e
        format.json { render json: {status: :failure, name: "Central", riding_id: 9000,
            riding_address_id: nil} }
      end
    end
  end

  # GET /riding_addresses/1
  # GET /riding_addresses/1.json
  def show
  end

  # GET /riding_addresses/new
  def new
    @riding_address = RidingAddress.new
  end

  # GET /riding_addresses/1/edit
  def edit
  end

  # POST /riding_addresses
  # POST /riding_addresses.json
  def create
    @riding_address = RidingAddress.new(riding_address_params)

    respond_to do |format|
      if @riding_address.save
        format.html { redirect_to @riding_address, notice: 'Riding address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @riding_address }
      else
        format.html { render action: 'new' }
        format.json { render json: @riding_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /riding_addresses/1
  # PATCH/PUT /riding_addresses/1.json
  def update
    respond_to do |format|
      if @riding_address.update(riding_address_params)
        format.html { redirect_to @riding_address, notice: 'Riding address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @riding_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /riding_addresses/1
  # DELETE /riding_addresses/1.json
  def destroy
    @riding_address.destroy
    respond_to do |format|
      format.html { redirect_to riding_addresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_riding_address
      @riding_address = RidingAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def riding_address_params
      params[:riding_address]
    end
end
