class Petition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :thank_you_message, type: String
  field :published, type: Boolean
  field :display_date, type: DateTime
  field :expiry_date, type: DateTime
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  
  has_and_belongs_to_many :users
end