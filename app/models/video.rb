class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_uri, type: String
  field :language, type: String
  field :created_date, type: DateTime
  field :title, type: String
  field :summary, type: String
  field :place, type: String
  field :category, type: String
  field :is_featured_video, type: Boolean
  field :is_biography_video, type: Boolean
  field :published, type: Boolean
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