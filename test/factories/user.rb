FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname Faker::Name.first_name
    email { Faker::Internet.safe_email(firstname) }
  end
end
