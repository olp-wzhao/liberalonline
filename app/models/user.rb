class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include User::AuthDefinitions
  include User::Roles
  include Geocoder::Model::Mongoid

  mount_uploader :image, ImageUploader

  field :name, type: String
  field :image, type: String
  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :gender, type: String
  field :hometown, type: String
  field :address, type: String
  field :postal_code, type: String
  field :city, type: String
  field :phone_number, type: String
  field :link, type: String
  field :location, type: String
  field :locale, type: String
  field :relationship_status, type: String
  field :significant_other, type: String
  field :timezone, type: String
  field :updated_time, type: DateTime
  field :work, type: String
  field :verified, type: Boolean
  field :roles_mask, type: Integer
  field :security_key, type: String
  field :title, type: String
  #field :riding_id, type: Integer
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :birthday, type: DateTime

  validates_presence_of :email, :first_name, :city, :postal_code, :address, :phone_number, :birthday
  validates_uniqueness_of :email

  #address_riding
  belongs_to :riding
  #membership riding

  has_many :identities
  has_many :invitees, :class_name => self.name, :as => :invited_by
  has_one :volunteer
  has_one :profile
  has_many :lawnsign_requests

  has_many :about_ridings
  has_many :art_contest_emails
  has_many :art_contest_items
  has_many :art_contest_votes
  has_many :attachments
  has_many :authorizations
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
  has_many :elect_attachments
  has_many :elect_customized_managements
  has_many :elect_documents
  has_many :elect_events
  has_many :elect_pdfs
  has_many :elect_photo_albums
  has_many :elect_photos
  has_many :elect_rotators
  has_many :elect_site_menus
  has_many :elect_video_galleries
  has_many :elect_videos
  has_many :endorsements
  has_many :enews_duplicate_subscribers
  has_many :enews_subscribers
  has_many :event_registers
  has_many :events
  
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
  has_many :pla_photo_albums
  has_many :pla_photos
  has_many :pla_public_feed_items
  has_many :pla_rotators
  has_many :pla_site_menus
  has_many :pla_video_galleries
  has_many :pla_videos
  has_many :pla_web_skins
  has_many :public_feed_items
  has_many :recognition_scrolls
  has_many :riding_executives

  has_many :rotators
  has_many :site_menus
  has_many :video_galleries
  has_many :videos
  has_many :web_skins
  has_many :transactions

  accepts_nested_attributes_for :volunteer
  accepts_nested_attributes_for :lawnsign_requests

  def full_name
    "#{first_name} #{last_name}"
  end

  geocoded_by :postal_code
  after_validation :geocode, :add_to_riding

  field :coordinates, :type => Array

  def add_to_riding
    #check for postal code and find the nearest riding or add them to a central riding
    if self.postal_code.nil?
      self.riding = Riding.where(riding_id: 0).first

      #this condition should only exist with new data. Consider removing it if the system is stable
      if self.riding.web_site_manager.nil?
        web_site_manager = WebSiteManager.new
        web_site_manager.r_id = 9000
        web_site_manager.r_str = 'olp'
        web_site_manager.r_name_en = 'ontario'
        self.riding.web_site_manager = web_site_manager
      end
    else
      #check if the postal code is valid
      if Geocoder.search(self.postal_code).empty?
        #if the riding cannot be found assign them to the central
        self.riding = Riding.where(riding_id: 0).first
      else
        self.riding = RidingAddress.near(self.postal_code, 10, :order => :distance).first.riding
      end

      if self.riding.web_site_manager.nil? || self.riding.web_site_manager.r_name_en == 'ontario'
        self.riding.web_site_manager = WebSiteManager.where(r_id: self.riding.riding_id + 9000).first
      end
    end
  end

  validates_numericality_of :age, :greater_than => 13, :message => "must be 13 or older"

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end
end