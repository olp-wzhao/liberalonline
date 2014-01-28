class SiteMenu
  include Mongoid::Document
  include Mongoid::Timestamps
  field :menu_en, type: String
  field :menu_fr, type: String
  field :web_site, type: String

  belongs_to :riding
  belongs_to :user

  field :temp_id, type: Integer
end