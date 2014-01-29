class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :prefix, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :street_address, type: String
  field :postal_code, type: String
  field :city, type: String
  field :telephone, type: String
  field :email, type: String
  field :card_name, type: String
  field :card_security, type: String
  field :card_expiry, type: DateTime
  field :card_reference, type: String
  field :card_type, type: String
  field :personal, type: Float
  field :company_name, type: String
  field :user_ip, type: String
  field :origin_url, type: String
  field :target_url, type: String
  field :promo_code, type: String
  field :gateway_response, type: String
  field :home_riding, type: Float
  field :type, type: String
  field :comments, type: String
  field :complete, type: Float
  field :reference, type: String
  field :temp_id, type: Integer
  field :success, type: Boolean
  
  belongs_to :user
end