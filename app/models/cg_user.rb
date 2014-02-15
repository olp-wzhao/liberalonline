class CgUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :last_name, type: String
  field :first_name, type: String
  field :address, type: String
  field :postal_code, type: String
  field :email, type: String
  field :city, type: String
  field :phone_number, type: String
  field :summary, type: String
  field :style, type: String
  field :cgf_email, type: Boolean
  field :cgf_message, type: Boolean
  field :cgf_volunteer, type: Boolean
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :age, type: Integer
  field :gender, type: String
  field :language, type: String
  field :confirmed, type: Boolean
  field :password, type: String
  field :security_key, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end