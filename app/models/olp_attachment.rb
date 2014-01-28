class OlpAttachment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :icon_uri, type: String
  field :language, type: String
  field :group_id, type: Integer#, :references => groups
  field :upload_date, type: DateTime
  field :title, type: String
  field :description, type: String
  field :place, type: String
  field :database_name, type: String
  field :file_location, type: String
  field :attachment_type, type: Integer
  field :published, type: Boolean
  field :riding_id, type: Integer#, :references => ridings
  field :web_site, type: String
  field :user_id, type: Integer#, :references => users

  field :temp_id, type: Integer
end