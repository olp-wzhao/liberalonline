class ElectRotator
  include Mongoid::Document
  include Mongoid::Timestamps

  field :database_name, type: String
  field :rotator_index, type: Integer
  field :created_date, type: DateTime
  field :is_local_published, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :document
  belongs_to :riding
  belongs_to :user

end