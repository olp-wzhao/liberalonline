class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :complete, type: Boolean, default: false

  validates_presence_of :complete
end