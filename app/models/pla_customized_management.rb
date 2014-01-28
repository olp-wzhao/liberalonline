class PlaCustomizedManagement
  include Mongoid::Document
  include Mongoid::Timestamps

  field :central_table, type: String
  field :local_value_en, type: String
  field :local_value_fr, type: String
  field :local_name_en, type: String
  field :local_name_fr, type: String
  field :local_title_en, type: String
  field :local_title_fr, type: String
  field :local_headline_en, type: String
  field :local_headline_fr, type: String
  field :local_subtitle_en, type: String
  field :local_subtitle_fr, type: String
  field :local_caption_en, type: String
  field :local_caption_fr, type: String
  field :local_note_en, type: String
  field :local_note_fr, type: String
  field :central_record_index, type: Integer
  field :created_date, type: DateTime
  field :is_local_published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end