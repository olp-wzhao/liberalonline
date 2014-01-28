class ArtContestEmail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :confirmed, type: Boolean
  field :security_key, type: String
  field :is_bad_email_address, type: Boolean
  field :web_site, type: String
  field :register_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end