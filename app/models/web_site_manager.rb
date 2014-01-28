class WebSiteManager
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :riding

  #r stands for riding
  field :r_id, type:  Integer#, type: :references => rs
  field :r_str, type:     String, default: 'olp'
  field :r_name_en, type: String, default: 'ontario'
  field :r_name_fr, type: String, default: 'ontario'
  field :r_about_en, type: String
  field :r_about_fr, type: String
  field :r_rc, type:  Integer
  field :r_fsr, type: Boolean
  #c = candidate?
  field :c_dl, type: String
  field :c_dd, type: String
  field :c_sl, type: String
  field :c_sd, type: String
  field :c_nl, type: String
  field :c_nf, type: String
  field :c_nm, type: String
  field :c_gender, type: Boolean
  field :c_incumbent, type: Boolean
  field :c_email, type: String
  field :c_fo, type: Boolean
  field :c_fi, type: Boolean
  field :c_fb, type: Boolean 
  field :c_fpes, type: Boolean, default: 'false'
  field :c_svl, type: String
  field :c_svc, type: String
  field :c_svr, type: String
  field :c_cm_en, type: String
  field :c_cm_fr, type: String
  field :c_ps_en, type: String
  field :c_ps_fr, type: String
  field :c_gaa, type: String
  field :c_home_page, type: String
  #I think the m_ fields are mpp
  field :m_dl, type: String
  field :m_dd, type: String
  field :m_sl, type: String
  field :m_sd, type: String
  #name last?
  field :m_nl, type: String
  #name first?
  field :m_nf, type: String
  field :m_nm, type: String
  field :m_gender, type: Boolean
  field :m_email, type: String
  field :m_fo, type: Boolean
  field :m_fi, type: Boolean
  field :m_fb, type: Boolean
  field :m_fpes, type: Boolean, default: 'false'
  field :m_svl, type: String
  field :m_svc, type: String
  field :m_svr, type: String
  field :m_cm_en, type: String
  field :m_cm_fr, type: String
  field :m_ps_en, type: String
  field :m_ps_fr, type: String
  field :m_gaa, type: String
  field :m_home_page, type: String
  #p = pla
  field :p_dl, type: String
  field :p_dd, type: String
  field :p_sl, type: String
  field :p_sd, type: String
  field :p_nl, type: String
  field :p_nf, type: String
  field :p_nm, type: String
  field :p_gender, type: Boolean
  field :p_email, type: String
  field :p_fo, type: Boolean
  field :p_fi, type: Boolean
  field :p_fb, type: Boolean
  field :p_fpes, type: Boolean, default: 'false'
  field :p_svl, type: String
  field :p_svc, type: String
  field :p_svr, type: String
  field :p_cm_en, type: String
  field :p_cm_fr, type: String
  field :p_ps_en, type: String
  field :p_ps_fr, type: String
  field :p_gaa, type: String
  field :p_home_page, type: String
  field :expiry_date, type: DateTime
  field :online_date, type: DateTime
  field :temp_id, type: Integer


end