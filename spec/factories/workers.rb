FactoryGirl.define do
  factory :worker do
    first_name 'Usie'
    last_name 'Userson'
    sequence(:mobile_number, 100000000){ |n| "+27#{n}"} 
    password 'please123'
    confirmed_at Time.now
  end
end
