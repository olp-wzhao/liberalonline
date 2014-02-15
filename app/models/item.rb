class Item
  include Mongoid::Document


  field :description, type: String
  field :qty, type: Float
  field :price, type: Float
  field :total, type: Float
  

end