class WebSite
  include Mongoid::Document
  include Mongoid::Timestamps

  field :web_site_name, type: String
  field :web_site_url, type: String
  field :email, type: String
  field :account_type, type: String
  field :account_status, type: String
  field :created_date, type: DateTime
  field :expiry_date, type: DateTime
  field :online_date, type: DateTime
  field :login_ip, type: String
  field :security_key, type: String
  field :web_site_type, type: String
  field :online_switch, type: Boolean
  field :index_switch, type: Boolean
  field :bilingual_switch, type: Boolean
  field :popup_enews_subscribe, type: Integer
  field :google_analytics_account, type: String
  field :shared_lview, type: String
  field :shared_cview, type: String
  field :shared_rview, type: String
  field :customized_menu_en, type: String
  field :customized_menu_fr, type: String
  field :page_special_en, type: String
  field :page_special_fr, type: String
  
  belongs_to :riding
  field :temp_id, type: Integer

end