class PetitionSubscriber
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :address, type: String
  field :email, type: String
  field :language, type: String
  field :confirmed, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :petition
  belongs_to :user

end