FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
#    role 'worker'
    first_name "Usie"
    last_name "Userson"
    sequence(:mobile_number, 100000000){ |n| "+27#{n}" }
#    email "test@example.com"
    password "please123"

#    trait :admin do
#      role 'admin'
#    end
  end
end

