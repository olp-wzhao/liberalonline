class LawnsignRequest
  include Mongoid::Document


  field :sign_size_large, type: Boolean
  field :message, type: String
  
  belongs_to :riding
  belongs_to :user

  accepts_nested_attributes_for :user
end
