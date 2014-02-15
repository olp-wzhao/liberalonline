class RecognitionScroll
  include Mongoid::Document
  include Mongoid::Timestamps

  field :requestor_email, type: String
  field :requestor_name, type: String
  field :requestor_city, type: String
  field :requestor_province, type: String
  field :requestor_postal_code, type: String
  field :requestor_address, type: String
  field :requestor_phone, type: String
  field :recipient_name, type: String
  field :recipient_address, type: String
  field :recipient_city, type: String
  field :recipient_province, type: String
  field :recipient_postal_code, type: String
  field :event_name, type: String
  field :recipient_language, type: String
  field :additional_note, type: String
  field :event_date, type: DateTime
  field :created_date, type: DateTime
  field :security_key, type: String
  field :gender, type: String
  field :language, type: String
  field :confirmed, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end