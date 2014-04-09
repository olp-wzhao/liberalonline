# class  Api::V1::TransactionsController < ApiController
#   before_action :set_transaction, only: [:show, :destroy]
#   respond_to :json
#
#   # GET /transactions
#   # GET /transactions.json
#   def index
#     search_params
#
#     @transactions = @transactions.order_by(id: :desc).limit(100)
#     respond_to do |format|
#       format.json { render json: @transactions }
#     end
#   end
#
#   # GET /transactions/1
#   # GET /transactions/1.json
#   def show
#     @transaction = Transaction.find(params[:id])
#     respond_to do |format|
#       format.json { render json: @transaction }
#     end
#   end
#
#   # GET /transactions/new
#   def new
#     @transaction = Transaction.new
#     respond_to do |format|
#       format.json { render json: @transaction }
#     end
#   end
#
#   # GET /transactions/1/edit
#   def edit
#   end
#
#   # POST /transactions
#   # POST /transactions.json
#   def create
#     success = false
#     # @transaction = Transaction.where(temp_id: transaction_params["temp_id"])
#     # if @transaction.any?
#     #   @transaction = @transaction.first
#     #   success = @transaction.update(transaction_params)
#     # else
#     @transaction = Transaction.new(transaction_params)
#     success = @transaction.save
#     #end
#     respond_to do |format|
#       if success
#         #format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
#         #succesful transactions will attempt to check for a new user
#         #create_or_update_transaction_user(@transaction)
#         format.json { render json: { transaction_id: @transaction.id }, status: :created  }
#       else
#         #format.html { render action: 'new' }
#         format.json { render json: @transaction.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /transactions/1
#   # PATCH/PUT /transactions/1.json
#   def update
#     respond_to do |format|
#       if @transaction.update(transaction_params)
#         #format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
#         format.json { render json: {status: :success } }
#       else
#         #format.html { render action: 'edit' }
#         format.json { render json: @transaction.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /transactions/1
#   # DELETE /transactions/1.json
#   def destroy
#     @transaction.destroy
#     respond_to do |format|
#       format.json { head :no_content }
#     end
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_transaction
#     @transaction = Transaction.find_or_create_by(temp_id: params[:id])
#   end
#
#   # Never trust parameters from the scary internet, only allow the white list through.
#   def transaction_params
#     params.require(:transaction).permit(:first_name, :last_name,
#                                         :prefix,
#                                         :street_address,
#                                         :postal_code,
#                                         :city,
#                                         :telephone,
#                                         :email,
#                                         :card_name,
#                                         :card_security,
#                                         #:card_expiry,
#                                         #:card_reference,
#                                         :card_type,
#                                         :personal,
#                                         :company_name,
#                                         :user_ip,
#                                         :origin_url,
#                                         :target_url,
#                                         :promo_code,
#                                         #:gateway_response,
#                                         :home_riding,
#                                         :type,
#                                         :comments,
#                                         :complete,
#                                         :reference,
#                                         :temp_id,
#                                         :success,
#                                         :total)
#   end
#
#   def search_params
#     if !params[:scope].nil?
#       @scope = params[:scope]
#       case @scope
#         when 'donations'
#           @transactions = Transaction.donations
#         when 'memberships'
#           @transactions = Transaction.memberships
#         when 'volunteers'
#           @transactions = Transaction.volunteers
#         when 'under_twenty_dollars'
#           @transactions = Transaction.under_twenty_dollars
#         else
#           @transactions = Transaction.all
#       end
#     else
#       @transactions = Transaction.all
#     end
#     params.each do |key, value|
#       # target groups using regular expressions
#       skip_list = ['auth_token', 'action', 'controller', 'format', "scope"]
#       unless skip_list.include?(key)
#         @transactions = @transactions.where(key => value)
#       end
#     end
#
#   end
#
#   def controller_scopes
#     @total_transactions = Transaction.sum(:total)
#     @membership_count = Transaction.memberships.count
#     @donation_count = Transaction.donations.count
#   end
#
#   # def create_or_update_transaction_user(transaction)
#   #   # Check for unique email and don't attempt to create a new user
#
#   #   if cookies["liberalonline_user_id"].nil?
#   #     @user = User.create( { first_name: transaction.first_name,
#   #       last_name: transaction.last_name,
#   #       address: transaction.street_address,
#   #       postal_code: transaction.postal_code,
#   #       city: transaction.city,
#   #       phone_number: transaction.telephone,
#   #       email: transaction.email } )
#   #   else
#   #     @user = User.find(cookies["liberalonline_user_id"])
#   #   end
#   #   @user.transactions << transaction
#   #   @user.save!(validate: false)
#   # end
#
# end
