FactoryBot.define do
  factory :reservation do
    sequence(:name) { |n| "Guest #{n}" }
    sequence(:email) { |n| "guest#{n}@example.com" }
    sequence(:phone) { |n| "123456789#{n}" }
    number_of_guests 50
    date_time { Time.now + 1 }
    sequence(:message) { |n| "Message #{n}" }
  end
end
