class ElectEvent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :event_datetime, type: DateTime
  field :location, type: String
  field :address, type: String
  field :address_hint, type: String
  field :email, type: String
  field :contact_person, type: String
  field :phone_number, type: String
  field :summary, type: String
  field :member_only, type: Boolean
  field :style, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :updated_ip, type: String
  field :language, type: String
  field :doc_type, type: Integer
  field :published, type: Boolean
  field :display_date, type: DateTime
  field :expiry_date, type: DateTime
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end