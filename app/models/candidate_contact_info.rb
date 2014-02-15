class CandidateContactInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :address, type: String
  field :city, type: String
  field :postal_code, type: String
  field :email, type: String
  field :phone, type: String
  field :tollfree_phone, type: String
  field :fax, type: String
  field :office_hours, type: String
  field :note, type: String
  field :office_type, type: String
  field :language, type: String
  field :public_status, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end