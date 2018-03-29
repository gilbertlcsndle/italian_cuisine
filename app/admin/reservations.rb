ActiveAdmin.register Reservation do
  member_action :confirm, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.confirm
    redirect_back fallback_location: root_path
  end

  member_action :close, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.close
    redirect_back fallback_location: root_path
  end

  action_item :confirm, only: :show do
    link_to 'Confirm', confirm_admin_reservation_path(reservation), method: :put
  end

  action_item :close, only: :show do
    link_to 'Close', close_admin_reservation_path(reservation), method: :put
  end

  scope :all, default: true
  scope :pending
  scope :confirmed
  scope :closed

  index do
    column :name
    column :number_of_guests
    column :date_time
    column :status
    column :created_at
    column :updated_at
    actions
  end
end
