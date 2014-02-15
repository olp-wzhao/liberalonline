class ElectVideoGallery
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description_en, type: String
  field :description_fr, type: String
  field :published, type: Boolean
  field :web_site, type: String
  field :created_date, type: DateTime
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end