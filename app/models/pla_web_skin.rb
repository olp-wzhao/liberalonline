class PlaWebSkin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :background, type: String
  field :menu_style, type: String
  field :font_set, type: String
  field :column_layout, type: String
  field :module_option, type: String
  field :plugin_option, type: String
  field :border_style, type: String
  field :body_style, type: String
  field :other_style, type: String
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end