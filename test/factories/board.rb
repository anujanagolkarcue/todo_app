FactoryGirl.define do  
  factory :board do  
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user  
  end  
end  