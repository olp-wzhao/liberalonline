class MppSiteMenu
  include Mongoid::Document
  include Mongoid::Timestamps

  field :menu_en, type: String
  field :menu_fr, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end