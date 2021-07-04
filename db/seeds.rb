Reservation.skip_callback(:create, :after, :send_details_to_admin, :send_notification_to_client)

date_time = DateTime.now.next_month
50.times do
  name = Faker::Name.name
  end_date_time = 7.day.from_now(date_time) 
  r = Reservation.new(name: name,
                      email: "#{name.parameterize(separator: '_')}@example.com",
                      phone: "09#{(0..8).to_a.shuffle[0..8].join}".to_i,
                      number_of_guests: (1..5).to_a.shuffle.first,
                      date_time:  date_time,
                      end_date_time:  end_date_time)
  r.save!(validate: false)

  date_time = date_time.next_month
end

Reservation.upcoming.limit(25).each do |reservation|
  reservation.confirm(notify: false)
end

if Rails.env.development?
  a = AdminUser.new(email: 'admin@example.com',
                        password: 'password',
                        password_confirmation: 'password') 
    a.skip_confirmation!
    a.save!
end

if Rails.env.production?
  a = AdminUser.new(email: ENV['ADMIN_EMAIL'],
                    password: ENV['ADMIN_PASSWORD'],
                    password_confirmation: ENV['ADMIN_PASSWORD']) 

  a.skip_confirmation!
  a.save!
end
