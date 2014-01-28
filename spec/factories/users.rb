FactoryGirl.define do
  factory:user do
    first_name "test"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "secret1234"
  end
end
