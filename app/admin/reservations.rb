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

  filter :name
  filter :number_of_guests, as: :select
  filter :date_time
  filter :created_at
  filter :updated_at

  scope :all, default: true
  scope :pending
  scope :confirmed
  scope :closed

  index do
    selectable_column
    column :name
    column :number_of_guests
    column 'Date', :date_time do |reservation|
      reservation.date_time.strftime('%B %-d, %Y %I:%M %P')
    end
    column :status do |reservation|
      case reservation.status
      when 'Pending'
        status_tag reservation.status, :warning
      when 'Confirmed'
        status_tag reservation.status, :ok
      when 'Closed'
        status_tag reservation.status
      end
    end
    column :created_at do |reservation|
      reservation.created_at.strftime('%B %-d, %Y %I:%M %P')
    end
    column :updated_at do |reservation|
      reservation.updated_at.strftime('%B %-d, %Y %I:%M %P')
    end
    actions
  end
end
