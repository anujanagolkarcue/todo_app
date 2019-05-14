FactoryGirl.define do  
  factory :card do  
    title Faker::Lorem.sentence  
    description Faker::Lorem.paragraph  
    starting_at { Time.now }
    expiry_at { Time.now.advance(days: 3) }
    reminder_at { Time.now.advance(days: 2) }
    reminder_description Faker::Lorem.paragraph
    board  
  end  
end  
