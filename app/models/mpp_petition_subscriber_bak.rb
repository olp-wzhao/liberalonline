class MppPetitionSubscriberBak
  include Mongoid::Document
  include Mongoid::Timestamps

  field :petition_info, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :subscribe_date, type: DateTime
  field :address, type: String
  field :address_street_number, type: String
  field :address_street_name, type: String
  field :address_apt_number, type: String
  field :city, type: String
  field :province, type: String
  field :postal_code, type: String
  field :email, type: String
  field :phone_number, type: String
  field :note, type: String
  field :confirmed, type: Boolean
  field :partisan, type: Boolean
  field :db_role, type: String
  field :language, type: String
  field :security_key, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :source_url, type: String
  
  belongs_to :petition
  belongs_to :riding
  belongs_to :user

end