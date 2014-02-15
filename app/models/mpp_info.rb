class MppInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :salutation, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :title_en, type: String
  field :title_fr, type: String
  field :cabinet_minister_en, type: String
  field :cabinet_minister_fr, type: String
  field :biography_partisan_en, type: String
  field :biography_partisan_fr, type: String
  field :biography_introduction_partisan_en, type: String
  field :biography_introduction_partisan_fr, type: String
  field :biography_non_partisan_en, type: String
  field :biography_non_partisan_fr, type: String
  field :biography_introduction_non_partisan_en, type: String
  field :biography_introduction_non_partisan_fr, type: String
  field :image_url, type: String
  field :web_site_url, type: String
  field :note_en, type: String
  field :note_fr, type: String
  field :elected_date, type: DateTime
  field :actived, type: Boolean
  field :is_cabinet_minister, type: Boolean
  field :is_parliamentary_assistant, type: Boolean
  field :published, type: Boolean
  field :suspended, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end