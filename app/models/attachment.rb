class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :pdf, PdfUploader

  field :icon_uri, type: String
  field :language, type: String
  field :upload_date, type: DateTime
  field :title, type: String
  field :description, type: String
  field :place, type: String
  field :database_name, type: String
  field :file_location, type: String
  field :attachment_type, type: Integer
  field :published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :file_size, type: Integer
  field :temp_id, type: Integer
  
  #belongs_to :riding
  belongs_to :document

end