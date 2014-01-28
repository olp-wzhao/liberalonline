class Lawnsign
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :last_name, type: String
  field :first_name, type: String
  field :available_date, type: DateTime
  field :confirmed_date, type: DateTime
  field :address, type: String
  field :postal_code, type: String
  field :email, type: String
  field :city, type: String
  field :phone_number, type: String
  field :summary, type: String
  field :member_only, type: Boolean
  field :style, type: String
  field :created_date, type: DateTime
  field :created_ip, type: String
  field :age, type: Integer
  field :gender, type: String
  field :language, type: String
  field :person_type, type: Integer
  field :person_level, type: Integer
  field :confirmed, type: Boolean
  field :canvassing, type: Boolean
  field :sign_crew, type: Boolean
  field :dropping_literature, type: Boolean
  field :office_work, type: Boolean
  field :election_day, type: Boolean
  field :driver, type: Boolean
  field :scrutineer, type: Boolean
  field :sign_size_large, type: Boolean
  field :availability_weekdays, type: Boolean
  field :availability_weeknights, type: Boolean
  field :availability_weekends, type: Boolean
  field :web_site, type: String
  field :updated_time, type: DateTime
  
  belongs_to :riding
  belongs_to :user

end