class MppPetition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :headline, type: String
  field :subtitle, type: String
  field :introduction, type: String
  field :body, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :updated_ip, type: String
  field :language, type: String
  field :published, type: Boolean
  field :document_date, type: DateTime
  field :display_date, type: DateTime
  field :expiry_date, type: DateTime
  field :image_name, type: String
  field :publish_on_olp, type: Boolean
  field :publish_on_mpp, type: Boolean
  field :publish_on_pla, type: Boolean
  field :publish_on_elect, type: Boolean
  field :partisan, type: Boolean
  field :is_draft, type: Boolean
  field :is_simple_signup, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end