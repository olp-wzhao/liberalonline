class ElectPhoto
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename, type: String
  field :created_date, type: DateTime
  field :caption_en, type: String
  field :caption_fr, type: String
  field :published, type: Boolean
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :source_url, type: String
  
  belongs_to :riding
  belongs_to :user

end