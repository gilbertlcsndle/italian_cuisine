Reservation.skip_callback(:create, :after, :send_details_to_admin, :send_notification_to_client)
Reservation.create!(name: 'John Doe',
                    email: 'johndoe@example.com',
                    phone: 123456789,
                    number_of_guests: 50,
                    date_time: 1.month.from_now,
                    message: 'Hello World!')
AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(email: ENV['ADMIN_EMAIL'],
                  password: ENV['ADMIN_PASSWORD'],
                  password_confirmation: ENV['ADMIN_PASSWORD']) if Rails.env.production?
