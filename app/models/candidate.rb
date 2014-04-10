class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :salutation, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :title_en, type: String
  field :title_fr, type: String
  field :biography_partisan_en, type: String
  field :biography_partisan_fr, type: String
  field :biography_non_partisan_en, type: String
  field :biography_non_partisan_fr, type: String
  field :image_url, type: String
  field :web_site_url, type: String
  field :note_en, type: String
  field :note_fr, type: String
  field :elected_date, type: DateTime
  field :priority_contact, type: String
  field :priority_phone, type: String
  field :priority_email, type: String
  field :tagline, type: String
  field :sna_twitter, type: String
  field :sna_facebook, type: String
  field :sna_linkedin, type: String
  field :sna_youtube, type: String
  field :bilingual_flag, type: Boolean
  field :campaign_manager, type: String
  field :campaign_email, type: String
  field :campaign_phone, type: String
  field :campaign_fax, type: String
  field :campaign_address, type: String
  field :actived, type: Boolean
  field :published, type: Boolean
  field :suspended, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :riding_id, type: Integer
  field :temp_id, type: Integer
  
  #belongs_to :riding
  belongs_to :user

end