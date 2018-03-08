class ReservationMailerPreview < ActionMailer::Preview
  def new_reservation
    ReservationMailer.new_reservation(Reservation.first)
  end
end
