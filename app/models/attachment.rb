class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :pdf, PdfUploader

  field :icon_uri, type: String
  field :title, type: String
  field :description, type: String
  field :database_name, type: String
  field :file_location, type: String
  field :attachment_type, type: Integer
  field :temp_id, type: Integer
  
  #belongs_to :riding
  belongs_to :document

  validates_presence_of :title, :pdf

end