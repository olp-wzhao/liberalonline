class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include User::AuthDefinitions
  include User::Roles
  include Mongoid::Search
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
  field :work, type: String
  field :verified, type: Boolean
  field :roles_mask, type: Integer
  field :security_key, type: String
  field :title, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :birthday, type: DateTime, default: Date.new
  field :referal_url, type: String

  validates_presence_of :email, :postal_code #, :first_name, :city, :address, :phone_number, :birthday
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, allow_nil: false
  validates_length_of :email, minimum: 4

  validates_numericality_of :age, :greater_than => 13, :message => "must be 13 or older"

  #validates_format_of :postal_code, with: /[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTWVXYZ]\d[ABCEGHJKLMNPRSTWVXYZ]\d/
  validates_length_of :first_name, minimum: 2
  validates_length_of :last_name, minimum: 2

  belongs_to :riding

  has_many :identities
  has_many :invitees, :class_name => self.name, :as => :invited_by
  has_one :volunteer
  has_many :lawnsign_requests
  has_one :facebook_friend_list

  has_many :about_ridings
  has_many :art_contest_emails
  has_many :art_contest_items
  has_many :art_contest_votes
  has_many :attachments
  has_many :authorizations
  has_many :authors
  has_many :cg_users
  has_many :comments
  has_many :contact_messages
  has_many :customized_categories
  has_many :customized_managements
  has_many :documents
  has_many :endorsements
  has_many :enews_duplicate_subscribers
  has_many :enews_subscribers
  has_many :event_registers
  has_many :events

  has_and_belongs_to_many  :petitions
  
  has_many :photo_albums
  has_many :photos
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
  after_validation :geocode
  after_create :add_to_riding

  field :coordinates, :type => Array

  def add_to_riding
    #check for postal code and find the nearest riding or add them to a central riding
    if self.riding.nil? && self.riding_id.nil?
      if self.postal_code.nil?
        self.riding = Riding.where(riding_id: 0).first
        #this condition should only exist with new data. Consider removing it if the system is stable
        # if self.riding.web_site_manager.nil?
        #   web_site_manager = WebSiteManager.new
        #   web_site_manager.r_id = 9000
        #   web_site_manager.r_str = 'olp'
        #   web_site_manager.r_name_en = 'ontario'
        #   self.riding.web_site_manager = web_site_manager
        # end
      else
        #check if the postal code is valid
        if Geocoder.search(self.postal_code).empty?
          #if the riding cannot be found assign them to the central
          self.riding = Riding.where(riding_id: 0).first
        else
          if !RidingAddress.near(self.postal_code, 10, :order => :distance).empty?
           self.riding = RidingAddress.near(self.postal_code, 10, :order => :distance).first.riding
          else
            self.riding = Riding.where(riding_id: 0).first
          end
        end
        
        if !self.riding.nil?
          if self.riding.web_site_manager.nil? 
            self.riding.web_site_manager = WebSiteManager.where(r_id: self.riding.riding_id + 9000).first
          end
          if self.riding.web_site_manager.r_name_en == 'ontario'
            self.riding.web_site_manager = WebSiteManager.where(r_id: self.riding.riding_id + 9000).first
          end
        else
          #this is a really hacky table and this code is messy just to tie the riding to this one-to-one data. 
          #consider merging this entire table with the riding table
          self.riding = Riding.create(riding_id: 9000)
          self.riding.web_site_manager = WebSiteManager.create(r_id: 9000)
        end
      end
    end
  end

  def age
    now = Time.now.utc.to_date
    unless self.birthday.nil?
      now.year - self.birthday.year - (self.birthday.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

  def transactions
    Transaction.where(email: self.email)
  end

  def fetch_facebook_friends
    identity = Identity.where(user_id: self.id, provider: 'facebook')
    if identity.exists?
      graph = Koala::Facebook::API.new(identity.first.token)
      friends = graph.get_connections('me', 'friends')
      unless friends.nil?
        graph.get_object("me")
        #check for the existance of a previous facebook friend list
        if self.facebook_friend_list.nil?
          self.facebook_friend_list = FacebookFriendList.new
        end

        #loop through friends and save new friends and attach all to current user
        friends.each do |friend|
          #check if friend is already on the list. If they are then nothing is needed

          myface = self.facebook_friend_list.facebook_friends.where(facebook_id: friend['id'])
          unless myface.exists?
            f = FacebookFriend.where(id: friend['id'])

            #Create a new facebook user if f is empty
            if !f.exists?
              f = FacebookFriend.new
              f.facebook_id = friend['id']
              f.name = friend['name']
            end
            #add our newly created user
            self.facebook_friend_list.facebook_friends << f
            f.save
          end
        end
      end
    end
  end

  slug :full_name, history: true

  search_in :first_name, :last_name, :email
end