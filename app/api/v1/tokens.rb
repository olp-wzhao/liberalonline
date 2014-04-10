# require 'logger'
#
# module API
#   module V1
#     class Tokens < Grape::API
#       version 'v1'
#       format :json
#
#       # skip_before_filter :verify_authenticity_token
#       # respond_to :json
#       #include API::V1::Defaults
#
#       resource :tokens do
#         desc 'Validate user and return authentication token'
#         params do
#           requires :email, :password
#         end
#         post do
#           email = params[:email]
#           password = params[:password]
#
#           # if request.format != :json
#           #   render :status=>406, :json=>{:message=>"The request must be json"}
#           #   return
#           # end
#           if email.nil? or password.nil?
#             error!('The request must contain the user email and password.', 400)
#           end
#
#           @user=User.where(email: email.downcase).first
#
#           if @user.nil?
#             #logger.info("User #{email} failed signin, user cannot be found.").colorize(:red)
#             error!('Invalid email or passoword.', 401)
#           end
#           @user.ensure_authentication_token!
#           @user.save!
#
#           if not @user.valid_password?(password)
#             #logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
#             error!('Invalid email or passoword.', 401)
#           else
#             #logger.info(@user.authentication.token).colorize(:light_yellow)
#             headers['Authorization'] = @user.authentication_token
#             @user.authentication_token
#           end
#         end
#
#         # def destroy
#         #   @user=User.find_by_authentication_token(params[:id])
#         #   if @user.nil?
#         #     logger.info("Token not found.")
#         #     render :status=>404, :json=>{:message=>"Invalid token."}
#         #   else
#         #     @user.reset_authentication_token!
#         #     render :status=>200, :json=>{:token=>params[:id]}
#         #   end
#         # end
#
#       end
#     end
#   end
# end