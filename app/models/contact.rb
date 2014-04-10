class Contact

  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone_number, type: String
  field :postal_code, type: String
  field :body, type: String
  field :inquiry_type, type: String

  #attr_accessor :name, :email, :subject, :body

  validates :first_name, :last_name, :email, :phone_number, :postal_code, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  
  # def initialize(attributes = {})
  #   attributes.each do |name, value|
  #     send("#{name}=", value)
  #   end
  # end

  # def persisted?
  #   false
  # end

end
