Reservation.skip_callback(:create, :after, :send_details_to_admin)
Reservation.create!(name: 'John Doe',
                    email: 'johndoe@example.com',
                    phone: 123456789,
                    number_of_guests: 50,
                    date_time: 1.month.from_now,
                    message: 'Hello World!')
