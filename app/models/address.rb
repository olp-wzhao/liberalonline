class Address
  include Mongoid::Document

  field :address, type: String
  field :address2, type: String
  field :city, type: String
  field :province, type: String
  field :postal_code, type: String
  field :phone_number, type: String
  field :toll_free_phone_number, type: String
  field :fax_number, type: String
  field :email, type: String

end