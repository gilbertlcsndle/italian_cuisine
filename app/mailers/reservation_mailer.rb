class ReservationMailer < ApplicationMailer
  default to: "Gilbert <gilbertlcsndle@gmail.com>"

  def new_reservation(reservation)
    @reservation = reservation

    mail subject: 'You have a new reservation!'
  end
end
