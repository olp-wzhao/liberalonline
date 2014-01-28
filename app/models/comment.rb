class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :body, type: String
  field :language, type: String
  field :security_key, type: String
  field :posted_date, type: DateTime
  field :actived, type: Boolean
  field :published, type: Boolean
  field :suspended, type: Boolean
  field :comment_favorite, type: Integer
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :rate_number, type: Integer
  field :rate_ip, type: String
  field :db_role, type: String
  
  belongs_to :document
  belongs_to :comment
  belongs_to :user
  belongs_to :riding
  has_many :omni_facebook_users

end