class RidingAddress
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  

  field :street, type: String
  field :city, type: String
  field :postal_code, type: String
  field :riding_number, type: Integer
  
  # def address
  #   [street, city, postal_code].compact.join(', ')
  # end

  geocoded_by :postal_code
  after_validation :geocode

  field :coordinates, :type => Array

  belongs_to :riding
  validates_uniqueness_of :postal_code

end