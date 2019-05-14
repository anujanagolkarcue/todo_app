FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.paragraph
    user
    card
  end  
end  
