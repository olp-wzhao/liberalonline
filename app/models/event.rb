class Event
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
  field :require_register, type: Boolean
  field :member_only, type: Boolean
  field :style, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :updated_ip, type: String
  field :language, type: String
  field :doc_type, type: Integer
  field :feature_level, type: Integer
  field :ticket_for_sell, type: Boolean
  field :ticket_price_single, type: Integer
  field :ticket_price_pair, type: Integer
  field :ticket_price_table, type: Integer
  field :ticket_price_abc, type: Integer
  field :ticket_price_red_trillium, type: Integer
  field :ticket_price_youth, type: Integer
  field :ticket_price_senior, type: Integer
  field :ticket_price_observer, type: Integer
  field :ticket_price_free, type: Integer
  field :ticket_price_other, type: Integer
  field :ticket_price_option, type: Integer
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
  field :temp_id, type: Integer
  
  belongs_to :user
  belongs_to :riding
  has_many :event_registers

  accepts_nested_attributes_for :user



end