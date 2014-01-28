class Post
  include Mongoid::Document
  field :name, type: String
  field :title, type: String
  field :content, type: String

  field :temp_id, type: Integer
end
