class Riding
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, localize: true
  field :riding_id, type: Integer

  has_many :riding_addresses
  validates_presence_of :riding_id, :title
  #connect confusing table
  after_validation :attach_web_site_manager

  #TODO: WebSiteManager needs to be migrated into Riding instead of being referenced
  has_one :web_site_manager

  scope :central, -> { where(riding_id: 0) }

  field :address, type: String
  field :address2, type: String
  field :city, type: String
  field :province, type: String
  field :postal_code, type: String
  field :phone_number, type: String
  field :toll_free_phone_number, type: String
  field :fax_number, type: String
  field :email, type: String
  field :introduction_en, type: String
  field :introduction_fr, type: String
  field :language, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :updated_ip, type: String
  field :document_date, type: DateTime
  field :web_site, type: String
  field :updated_time, type: DateTime

  has_many :users
  has_many :pla_photo_albums
  has_many :art_contest_items
  has_many :art_contest_votes
  has_many :attachments
  has_many :authors
  has_many :candidate_authors
  has_many :candidate_contact_infos
  has_many :candidate_endorsements
  has_many :candidate_infos
  has_many :candidate_public_feed_items
  has_many :candidate_twitter_contents
  has_many :candidate_web_skins
  has_many :cg_users
  has_many :comments
  has_many :contact_messages
  has_many :customized_categories
  has_many :customized_managements
  has_many :documents
  #has_many :elect_attachments
  #has_many :elect_customized_managements
  #has_many :elect_documents
  #has_many :elect_events
  #has_many :elect_pdfs
  #has_many :elect_photo_albums
  #has_many :elect_photos
  #has_many :elect_rotators
  #has_many :elect_site_menus
  #has_many :elect_video_galleries
  #has_many :elect_videos
  has_many :endorsements
  has_many :enews_duplicate_subscribers
  has_many :enews_subscribers
  has_many :event_registers
  has_many :events
  has_many :lawnsigns
  has_many :mpp_attachments
  has_many :mpp_contact_infos
  has_many :mpp_customized_managements
  has_many :mpp_documents
  has_many :mpp_infos
  has_many :mpp_petition_subscribers
  has_many :mpp_petitions
  has_many :mpp_photo_albums
  has_many :mpp_photos
  has_many :mpp_public_feed_items
  has_many :mpp_rotators
  has_many :mpp_site_menus
  has_many :mpp_twitter_contents
  has_many :mpp_video_galleries
  has_many :mpp_videos
  has_many :omni_facebook_users
  has_many :petition_subscribers
  has_many :petitions
  has_many :photo_albums
  has_many :photos
  has_many :pla_attachments
  has_many :pla_customized_managements
  has_many :pla_documents
  has_many :pla_events
  has_many :pla_pdfs
  has_many :art_contest_emails
  has_many :pla_photos
  has_many :pla_public_feed_items
  has_many :pla_rotators
  has_many :pla_site_menus
  has_many :pla_video_galleries
  has_many :pla_videos
  has_many :pla_web_skins
  has_many :poll_stations
  has_many :public_feed_items
  has_many :recognition_scrolls
  has_many :riding_executives
  has_many :about_ridings
  has_many :admin_users
  has_many :rotators
  has_many :site_menus
  has_many :video_galleries
  has_many :videos
  has_many :volunteers
  has_many :web_sites
  has_many :web_skins

  def attach_web_site_manager
    self.web_site_manager = WebSiteManager.where(r_id: self.riding_id)
  end

  scope :central, -> { where(riding_id: 9000) }

end