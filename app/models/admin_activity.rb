class AdminActivity
  include Mongoid::Document


  field :name, type: String
  field :last_login, type: String
  

end