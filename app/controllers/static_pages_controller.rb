class StaticPagesController < ApplicationController
  def home
    @contact = Contact.new
    @reservation = Reservation.new
  end
end
