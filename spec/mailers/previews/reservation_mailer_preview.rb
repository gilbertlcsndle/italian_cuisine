class ReservationMailerPreview < ActionMailer::Preview
  def new_reservation
    ReservationMailer.new_reservation(Reservation.first)
  end

  def client_notification
    ReservationMailer.client_notification(Reservation.first)
  end
end
