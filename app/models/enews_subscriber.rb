class EnewsSubscriber
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :is_html_format, type: Boolean
  field :is_in_send_group, type: Boolean
  field :is_in_test_group, type: Boolean
  field :security_key, type: String
  field :web_site, type: String
  field :created_date, type: DateTime
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end