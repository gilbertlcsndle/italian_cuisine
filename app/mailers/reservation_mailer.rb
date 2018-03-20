class ReservationMailer < ApplicationMailer
  default to: "Gilbert <gilbertlcsndle@gmail.com>"

  def new_reservation(reservation)
    @reservation = reservation

    mail subject: 'You have a new reservation!'
  end

  def new_payment(reservation)
    @reservation = reservation

    mail to: reservation.email,
         subject: 'Your reservation at Osteriax is confirmed'
  end
end
