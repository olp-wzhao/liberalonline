class PlaPublicFeedItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :facebook_account, type: String
  field :facebook_label, type: String
  field :facebook_flag, type: Boolean
  field :twitter_account, type: String
  field :twitter_label, type: String
  field :twitter_count, type: Integer
  field :twitter_page, type: Integer
  field :twitter_flag, type: Boolean
  field :flickr_count, type: Integer
  field :flickr_account, type: String
  field :flickr_label, type: String
  field :flickr_flag, type: Boolean
  field :linkedin_count, type: Integer
  field :linkedin_account, type: String
  field :linkedin_label, type: String
  field :linkedin_flag, type: Boolean
  field :youtube_channel_account, type: String
  field :youtube_channel_label, type: String
  field :youtube_channel_flag, type: Boolean
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :updated_ip, type: String
  field :language, type: String
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