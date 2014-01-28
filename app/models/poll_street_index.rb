class PollStreetIndex
  include Mongoid::Document
  include Mongoid::Search
  field :electoral_id, type: Integer
  field :poll_division, type: Integer
  field :street_name, type: String
  field :place_name, type: String
  field :from_address, type: Integer
  field :to_address, type: Integer
  field :is_odd, type: Boolean

  belongs_to :riding

  search_in :street_name
end
