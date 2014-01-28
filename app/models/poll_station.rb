class PollStation
  include Mongoid::Document
  field :electoral_district, type: Integer
  field :poll_division, type: Integer
  field :location, type: String
  field :address1, type: String
  field :address2, type: String
  field :place, type: String

  belongs_to :riding
end