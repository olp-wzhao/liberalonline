class MppTwitterContent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_text, type: String
  field :first_datetime, type: DateTime
  field :second_text, type: String
  field :second_datetime, type: DateTime
  field :third_text, type: String
  field :third_datetime, type: DateTime
  field :language, type: String
  field :public_status, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end