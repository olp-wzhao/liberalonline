class CandidateAuthor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename, type: String
  field :role_en, type: String
  field :role_fr, type: String
  field :since_date, type: DateTime
  field :name_en, type: String
  field :name_fr, type: String
  field :published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :source_url, type: String
  
  belongs_to :riding
  belongs_to :user

end