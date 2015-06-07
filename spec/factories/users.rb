FactoryGirl.define do
  factory :user do
#    confirmed_at Time.now
#    role 'worker'
    first_name "Usie"
    last_name "Userson"
    mobile_number "0721111111"
#    email "test@example.com"
    password "please123"

#    trait :admin do
#      role 'admin'
#    end
  end
end

