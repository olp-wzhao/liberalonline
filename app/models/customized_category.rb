class CustomizedCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :db_name, type: String
  field :created_date, type: DateTime
  field :caption_en, type: String
  field :caption_fr, type: String
  field :published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :source_url, type: String
  
  belongs_to :riding
  belongs_to :user
  has_many :elect_documents
  has_many :documents
  has_many :mpp_documents
  has_many :pla_documents

end