Reservation.skip_callback(:create, :after, :send_details_to_admin, :send_notification_to_client)
Reservation.skip_callback(:create, :before, :set_status_to_pending)
50.times do
  name = Faker::Name.name
  Reservation.create!(name: name,
                      email: "#{name.parameterize(separator: '_')}@example.com",
                      phone: "09#{(0..8).to_a.shuffle[0..8].join}".to_i,
                      number_of_guests: (10..50).step(10).to_a.shuffle.first,
                      date_time:  Faker::Time.between(DateTime.now + 1, 30.days.from_now),
                      status: ['Pending', 'Confirmed', 'Closed'].shuffle.first,
                      message: Faker::Hipster.paragraph)
end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(email: ENV['ADMIN_EMAIL'],
                  password: ENV['ADMIN_PASSWORD'],
                  password_confirmation: ENV['ADMIN_PASSWORD']) if Rails.env.production?
