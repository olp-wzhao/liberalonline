FactoryGirl.define do
  factory :user do
    first_name 'Doctor'
    last_name 'Who'
    sequence(:email) { |n| "foo#{n}@example.com" }
    roles ['webadmin']
    postal_code 'M2H2N1'
    birthday Date.parse('31-12-1978')
    sequence(:password) { |n| "secret1234#{n}" }
    sequence(:password_confirmation) { |n| "secret1234#{n}" }
    city "Toronto"
    address "1 Rspec Dr"
    phone_number "555-5555"
    riding FactoryGirl.create(:riding)
    #after(:create) { |user| user.confirm! }
  end
end
