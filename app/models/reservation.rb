class Reservation < ApplicationRecord
  after_create :send_details_to_admin

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, numericality: { only_integer: true }
  validates :number_of_guests, presence: true
  validates :date_time, presence: true

  private
    def send_details_to_admin
      ReservationMailer.new_reservation(self).deliver_now
    end
end
