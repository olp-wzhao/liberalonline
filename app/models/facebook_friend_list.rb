class FacebookFriendList
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :facebook_friends
end