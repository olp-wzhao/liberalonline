class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_transaction, only: [:show, :destroy]
  respond_to :json

  # GET /transactions
  # GET /transactions.json
  def index
    search_params
    @transactions = Transaction.all.limit(100)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    success = false
    # @transaction = Transaction.where(temp_id: transaction_params["temp_id"])
    # if @transaction.any?
    #   @transaction = @transaction.first
    #   success = @transaction.update(transaction_params)
    # else
    @transaction = Transaction.new(transaction_params)
    success = @transaction.save
    #end
    #binding.pry
    respond_to do |format|
      if success
        #format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: {id: @transaction.temp_id, status: :created } }
      else
        #format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        #format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render json: {status: :success } }
      else
        #format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:first_name, :last_name,
        :prefix, 
        :street_address, 
        :postal_code, 
        :city, 
        :telephone, 
        :email, 
        :card_name, 
        :card_security, 
        :card_expiry, 
        :card_reference, 
        :card_type, 
        :personal,
        :company_name, 
        :user_ip, 
        :origin_url, 
        :target_url, 
        :promo_code, 
        :gateway_response, 
        :home_riding,
        :type, 
        :comments, 
        :complete,
        :reference, 
        :temp_id,
        :success)
    end

    def search_params
      params.each do |key, value|
        # target groups using regular expressions
        skip_list = ["auth_token", "action", "controller", "format"]
        unless skip_list.include?(key)
          @transactions = Transaction.where(key => value)
        end
      end
    end

end
