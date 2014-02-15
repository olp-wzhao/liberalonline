class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :prefix, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :street_address, type: String
  field :postal_code, type: String
  field :city, type: String
  field :telephone, type: String
  field :email, type: String
  field :card_name, type: String
  field :card_security, type: String
  field :card_expiry, type: DateTime
  field :card_reference, type: String
  field :card_type, type: String
  field :personal, type: Float
  field :company_name, type: String
  field :user_ip, type: String
  field :origin_url, type: String
  field :target_url, type: String
  field :promo_code, type: String
  field :gateway_response, type: String
  field :home_riding, type: Float
  field :type, type: String
  field :comments, type: String
  field :complete, type: Float
  field :reference, type: String
  field :temp_id, type: Integer
  field :success, type: Boolean
  field :total, type: Integer
  field :riding_id, type: Integer
  
  belongs_to :user
  before_create :set_total
  before_save :find_or_create_user

  scope :by_email, -> (email) { where(email: email).group } 
  scope :memberships, -> { where(type: "Membership") }
  scope :donations, -> { where(type: "Donation") }
  scope :events, -> { where(type: "Item") }
  scope :under_twenty_dollars, -> { lte(get_total: 20) }
  scope :total_sum, ->(email) { where(email: email).sum(:total) }
  #scope :between, -> (first, last) {  }

  def find_or_create_user
    if self.user.nil?
      self.user = User.find_or_create_by(email: self.email)
      if self.user.new_record?
        self.user = User.new(email: self.email, first_name: self.first_name, last_name: self.last_name, address: self.street_address, postal_code: self.postal_code, roles: [AppConfig.default_role])
        self.user.save!(validate: false)
      end
    end
  end

  def fill_total
    unless self.gateway_response.nil?
      dollars = Hash.from_xml(self.gateway_response)["Result"]["FullTotal"].to_f * 100
      self.total = Money.new(dollars, "CAD")
    end
  end

  def get_total
    if self.gateway_response.nil?
      0
    else
      Hash.from_xml(self.gateway_response)["Result"]["FullTotal"].to_i
    end
  end

  def check_and_set_total
    if self.total.nil?
      set_total
    end
  end

  def set_total
    self.total = get_total
  end

  # def fill_total_f
  #   @document
  #    self.total_f = Hash.from_xml(self.gateway_response)["Result"]["FullTotal"].to_f
  # end  

  # def self.total_overall
  #   sum('get_total')
  # end

  # def self.total_overall_f
  #   t = 0
  #   grouped_emails = self.where(email: "jessenaiman@gmail.com")
  #   t = grouped_emails.each { |e| t += e.total_f }
  #   t
  # end

  #scope: total_transactions_to_date, gt(expiry_date: DateTime.now).sum(:)
end