class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :headline, type: String
  field :subtitle, type: String
  field :introduction, type: String
  field :body, type: String
  field :author, type: String
  field :reference_url, type: String
  field :reference_name, type: String
  field :attached_photo_ids, type: String
  field :attached_video_ids, type: String
  field :attached_pdf_ids, type: String
  field :petition_ids, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :created_user_id, type: Integer
  field :updated_ip, type: String
  field :language, type: String
  field :helpfulness_rating, type: Integer
  field :applicability_rating, type: Integer
  field :allow_comment, type: Boolean
  field :published, type: Boolean
  field :copy_protect, type: Boolean
  field :document_date, type: DateTime
  field :display_date, type: DateTime
  field :expiry_date, type: DateTime
  field :image_name, type: String
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  field :author_photo, type: String
  field :is_draft, type: Boolean
  field :riding_id, type: Integer
  field :web_site, type: String
  field :user_id, type: Integer
  field :updated_time, type: DateTime
  field :updated_at, type:DateTime

  validates_presence_of :display_date

  #lets make this a table
  field :doc_type, type: Integer
  field :temp_id, type: Integer
  field :category_id, type: Integer
  field :customized_category_id, type: Integer 
  field :issue_id, type: Integer
  
  belongs_to :petition
  belongs_to :user
  belongs_to :customized_category
  belongs_to :riding
  has_many :elect_rotators
  has_many :comments
  has_many :mpp_rotators
  has_many :pla_rotators
  has_many :rotators
  has_many :attachments

  scope :mpp, -> { where(:riding_id => 0, :published => true, :publish_on_mpp => true).order_by(:document_date.desc) }
  scope :pla, -> { where(:riding_id => 0, :published => true, :publish_on_pla => true).order_by(:document_date.desc) }
  scope :elect, -> { where(:riding_id => 0, :published => true, :publish_on_elect => true).order_by(:document_date.desc) }

  #only central
  scope :press_release, -> { where(doc_type: 0).order_by(:document_date.desc) }
  scope :toolkit, -> { where(doc_type: 20).order_by(:document_date.desc) }
  

  scope :news_documents, -> {  where(:riding_id => 0, :published => true, :publish_on_pla => true)
                                     .between(doc_type: 0..1)
                                     .order_by(:document_date.desc) }

  # def initialize(options={})
  #   self.headline = options[:headline]
  # end


end