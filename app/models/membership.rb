class Membership
  include Mongoid::Document


  field :birthdate, type: DateTime
  field :term, type: Float
  field :price, type: Float
  

end