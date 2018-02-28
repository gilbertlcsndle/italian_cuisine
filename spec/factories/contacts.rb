FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Visitor #{n}" }
    sequence(:email) { |n| "visitor#{n}@email.com" }
    sequence(:subject) { |n| "Subject #{n}" }
    sequence(:message) { |n| "Message #{n}" }
  end
end
