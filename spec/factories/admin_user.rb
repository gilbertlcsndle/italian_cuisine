FactoryBot.define do
  factory :admin_user do
    email 'admin@example.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at DateTime.current
  end
end
