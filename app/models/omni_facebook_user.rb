class OmniFacebookUser
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
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :document
  belongs_to :comment
  belongs_to :riding
  belongs_to :user

end