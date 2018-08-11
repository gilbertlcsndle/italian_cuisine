Reservation.skip_callback(:create, :after, :send_details_to_admin, :send_notification_to_client)
50.times do
  name = Faker::Name.name
  r = Reservation.new(name: name,
                      email: "#{name.parameterize(separator: '_')}@example.com",
                      phone: "09#{(0..8).to_a.shuffle[0..8].join}".to_i,
                      number_of_guests: (10..50).step(10).to_a.shuffle.first,
                      date_time:  Faker::Time.between(DateTime.now - 2, 30.days.from_now),
                      message: Faker::Hipster.paragraph)
  r.save!(validate: false)
end

# close all reservations last two days and today
this = Date.today
last_two = Date.today - 2

Reservation.where(date_time: last_two.midnight..this.end_of_day).each do |reservation|
  reservation.close
end

# confirm some upcoming reservation
confirmed_count = (5..Reservation.upcoming.count).to_a.shuffle.first

Reservation.upcoming.order('RANDOM()').limit(confirmed_count).each do |reservation|
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
