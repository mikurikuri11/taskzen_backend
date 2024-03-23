FactoryBot.define do
  factory :user do
    provider { "MyProvider" }
    uid { "MyUid" }
    name { "MyName" }
    email { "myemail@example.com" }
    role { 0 }
    active { true }
  end
end
