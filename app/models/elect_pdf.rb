class ElectPdf
  include Mongoid::Document
  include Mongoid::Timestamps

  field :icon_uri, type: String
  field :language, type: String
  field :upload_date, type: DateTime
  field :title, type: String
  field :description, type: String
  field :place, type: String
  field :database_name, type: String
  field :published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end