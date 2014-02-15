class Endorsement
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quote, type: String
  field :name, type: String
  field :favourite_rate, type: Integer
  field :quote_date, type: DateTime
  field :title, type: String
  field :language, type: String
  field :published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :source, type: String
  
  belongs_to :riding
  belongs_to :user

end