class VideoGallery
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description_en, type: String
  field :description_fr, type: String
  field :published, type: Boolean
  field :web_site, type: String

  has_many :videos
  belongs_to :riding
  belongs_to :user

  field :temp_id, type: Integer
end