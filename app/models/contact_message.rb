class ContactMessage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :sender_email, type: String
  field :sender_phone, type: String
  field :postal_code, type: String
  field :message, type: String
  field :language, type: String
  field :security_key, type: String
  field :submit_date, type: DateTime
  field :is_mpp, type: Boolean
  field :is_pla, type: Boolean
  field :is_candidate, type: Boolean
  field :receiver_email, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end