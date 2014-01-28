class Gallery
  include Mongoid::Document
  field :name, type: String

  field :temp_id, type: Integer
end
