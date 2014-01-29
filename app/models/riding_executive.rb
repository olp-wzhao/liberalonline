class RidingExecutive
  include Mongoid::Document
  include Mongoid::Timestamps
  
  scope :presidents, -> { where(role_title: "President") }

  field :id, type: Integer
  field :title, type: String
  field :address, type: String
  field :address2, type: String
  field :city, type: String
  field :province, type: String
  field :postal_code, type: String
  field :phone_number, type: String
  field :toll_free_phone_number, type: String
  field :fax_number, type: String
  field :email, type: String
  field :role_code, type: Integer
  field :role_title, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :created_user_id, type: Integer #, :references => created_users
  field :updated_ip, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :first_name, type: String
  field :last_name, type: String
  field :order_index, type: Integer

  field :temp_id, type: Integer

  #belongs_to :riding

  #after_create :add_to_riding

  belongs_to :riding
  belongs_to :user

  protected
  def add_to_riding
    riding = Riding.find({id: riding_id})
    self.add_riding(riding)
  end
end