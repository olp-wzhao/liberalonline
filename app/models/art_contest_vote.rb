class ArtContestVote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :rate, type: Integer
  field :comment, type: String
  field :confirmed, type: Boolean
  field :web_site, type: String
  field :rate_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end