FactoryBot.define do
  factory :todo do
    user_id { 1 }
    title { "MyString" }
    description { "MyText" }
    due_date { Date.today + 7 } # Due date set to 7 days from today
    completed { false }
    zone { 0 }
    association :user, factory: :user # Assuming you have a user factory defined
  end
end
