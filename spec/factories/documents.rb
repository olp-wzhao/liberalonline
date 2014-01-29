# # Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    headline "factory_headline"
    display_date Date.new
  end
end
