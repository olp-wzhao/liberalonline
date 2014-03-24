class FacebookFriend
  include Mongoid::Document

  field :facebook_id, type: Integer
  field :name, type: String

  has_and_belongs_to_many :facebook_friend_lists
end