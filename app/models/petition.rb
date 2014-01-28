class Petition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :address, type: String
  field :city, type: String
  field :phone_number, type: String
  field :email, type: String
  field :title, type: String
  field :description, type: String
  field :thank_you_message, type: String
  field :created_date, type: DateTime
  field :language, type: String
  field :published, type: Boolean
  field :display_date, type: DateTime
  field :expiry_date, type: DateTime
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user
  has_many :mpp_petition_subscribers
  has_many :mpp_documents
  has_many :petition_subscribers
  has_many :documents
  has_many :elect_documents
  has_many :pla_documents

end