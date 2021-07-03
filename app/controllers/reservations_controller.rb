class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
  end

  private
    def reservation_params
      params.require(:reservation).permit(:name,
                                          :email,
                                          :phone,
                                          :number_of_guests,
                                          :date_time,
                                          :end_date_time)
    end
end
