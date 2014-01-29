class PlaDocument
  include Mongoid::Document
  include Mongoid::Timestamps

  field :headline, type: String
  field :subtitle, type: String
  field :introduction, type: String
  field :body, type: String
  field :author, type: String
  field :reference_url, type: String
  field :reference_name, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
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
  field :web_site, type: String
  field :updated_time, type: DateTime
  field :doctype, type: Integer
  
  belongs_to :petition
  belongs_to :customized_category
  belongs_to :riding
  belongs_to :user

end