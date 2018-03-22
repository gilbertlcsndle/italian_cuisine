ActiveAdmin.register Reservation do
  member_action :confirm, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.confirm
    redirect_back fallback_location: root_path
  end

  index do
    column :name
    column :email
    column :phone
    column :number_of_guests
    column :date_time
    column :status
    column :payment_status
    column :created_at
    column :updated_at
    actions do |post|
      item 'Confirm', confirm_admin_reservation_path(post), method: :put
    end
  end
end
