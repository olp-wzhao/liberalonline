 class Volunteer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :available_date, type: DateTime
  field :confirmed_date, type: DateTime
  field :summary, type: String
  field :member_only, type: Boolean
  field :style, type: String
  field :created_ip, type: String
  field :language, type: String
  field :person_type, type: Integer
  field :person_level, type: Integer

  field :availability_weekdays, type: Boolean
  field :availability_weeknights, type: Boolean
  field :availability_weekends, type: Boolean

  #Arts and Creative
  field :still_photography, type: Boolean
  field :video_production, type: Boolean
  field :graphic_design, type: Boolean
  field :voice_acting, type: Boolean
  field :set_design, type: Boolean
  field :screenwriter, type: Boolean
  field :web_design, type: Boolean
  field :composer, type: Boolean
  field :motion_graphics, type: Boolean

  #Analysis and Information Technology

  field :data_mining, type: Boolean
  field :process_analysis, type: Boolean
  field :programming, type: Boolean
  field :arc_view, type: Boolean
  field :excel, type: Boolean
  field :email_marketing, type: Boolean
  field :sql, type: Boolean

  #Election Experience
  field :trained_on_libe, type: Boolean
  field :canvassing, type: Boolean
  field :trained_on_liberalist, type: Boolean
  field :telemarketing, type: Boolean
  field :campaign_manager, type: Boolean
  field :digital_ad_buying, type: Boolean

  #Other
  field :printing, type: Boolean
  field :ad_buying, type: Boolean
  field :screen_printing, type: Boolean
  field :accounting, type: Boolean

  field :physical_limitation, type: String
  field :skill_set_note, type: String
  field :comment, type: String
  
  belongs_to :riding
  belongs_to :user

  accepts_nested_attributes_for :user

end