class ArtContestItem
  include Mongoid::Document
  include Mongoid::Timestamps

  

  field :name, type: String
  field :email, type: String
  field :description, type: String
  field :author, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :school_name, type: String
  field :grade_level, type: Integer
  field :published, type: Boolean
  field :item_url, type: String
  field :web_site, type: String
  field :submit_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end