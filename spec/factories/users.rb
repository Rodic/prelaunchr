FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@prelaunchr.com"
    end
    sequence :referral_code do |n|
      n
    end
    referrer_id 0
  end
end
