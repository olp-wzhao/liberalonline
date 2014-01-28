class Account
  include Mongoid::Document


  field :amount, type: Float
  field :account_number, type: String
  

end