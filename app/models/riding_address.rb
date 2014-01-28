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

  geocoded_by :postal_code#, :if => :address_changed?
  after_validation :geocode #, :reverse_geocode
  # reverse_geocoded_by :coordinates do |obj, results|
  #   if geo = results.first
  #     binding.pry
  #     obj.street      = geo.intersection["street"]
  #     obj.city        = geo.intersection["city"]
  #     obj.postal_code = geo.postal_code
  #   end
  # end

  field :coordinates, :type => Array

  belongs_to :riding
  validates_uniqueness_of :postal_code

end