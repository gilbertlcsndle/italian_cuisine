class ReservationMailer < ApplicationMailer
  def new_reservation(reservation)
    @reservation = reservation

    mail subject: 'You have a new reservation!',
         to: "Admin <#{ENV['GMAIL_USERNAME']}>"
  end

  def client_notification(reservation)
    @reservation = reservation

    mail subject: 'Your booking request is waiting to be confirmed.',
         to: "#{@reservation.name} <#{@reservation.email}>"
  end

  def confirmed_email(reservation)
    @reservation = reservation

    mail subject: 'Your booking request has been confirmed.',
         to: "#{@reservation.name} <#{@reservation.email}>"
  end
end
