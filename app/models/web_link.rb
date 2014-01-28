class WebLink
  include Mongoid::Document

  field :name   , type: String
  field :url    , type: String

  belongs_to :post

  field :temp_id, type: Integer
end