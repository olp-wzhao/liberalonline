class AboutRiding
  include Mongoid::Document
  include Mongoid::Timestamps

  field :id, type: Integer
  
  field :title, type: String
  field :address, type: String
  field :address2, type: String
  field :city, type: String
  field :province, type: String
  field :postal_code, type: String
  field :phone_number, type: String
  field :toll_free_phone_number, type: String
  field :fax_number, type: String
  field :email, type: String

  field :introduction_en, type: String
  field :introduction_fr, type: String
  field :language, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :created_user_id, type: Integer #, :references => created_users
  field :updated_ip, type: String
  field :document_date, type: DateTime
  #field :riding_id, type: Integer #, :references => ridings
  field :web_site, type: String

  #field :coordinates, :type => Array

  belongs_to :riding
  belongs_to :user
end