class Reservation < ApplicationRecord
  before_save { email.downcase! }
  after_create :send_details_to_admin, :send_notification_to_client
  before_create :set_status_to_pending

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :phone, presence: true, numericality: { only_integer: true }
  validates :number_of_guests, presence: true
  validates :date_time, presence: true

  scope :pending, -> { where(status: 'Pending') }
  scope :confirmed, -> { where(status: 'Confirmed') }
  scope :closed, -> { where(status: 'Closed') }
  scope :today, -> { where(date_time: Date.today.midnight..Date.today.end_of_day) }

  # show reservations greater than today
  def self.upcoming
    where('date_time > ?', Date.today.end_of_day)
  end

  def confirm(notify: true)
    update(status: 'Confirmed')
    if notify
      ReservationMailer.confirmed_email(self).deliver_now
    end
  end

  def close
    update(status: 'Closed')
  end

  private

    def set_status_to_pending
      self.status = 'Pending'
    end

    def send_details_to_admin
      ReservationMailer.new_reservation(self).deliver_now
    end

    def send_notification_to_client
      ReservationMailer.client_notification(self).deliver_now
    end
end
