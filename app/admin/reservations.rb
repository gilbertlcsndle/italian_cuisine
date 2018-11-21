ActiveAdmin.register Reservation do
  config.sort_order = 'created_at_desc'

  member_action :confirm, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.confirm
    redirect_back fallback_location: admin_reservations_path
  end

  member_action :close, method: :put do
    reservation = Reservation.find(params[:id])
    reservation.close
    redirect_back fallback_location: admin_reservations_path
  end

  action_item :confirm, only: :show do
    link_to 'Confirm', confirm_admin_reservation_path(reservation), method: :put
  end

  action_item :close, only: :show do
    link_to 'Close', close_admin_reservation_path(reservation), method: :put
  end

  scope :all, default: true
  scope :today
  scope :upcoming
  scope :pending
  scope :confirmed
  scope :closed

  filter :name
  filter :number_of_guests, as: :select
  filter :date_time
  filter :status, as: :select
  filter :created_at
  filter :updated_at

  batch_action :confirm, confirm: 'Are you sure you want to confirm these reservations?' do |ids|
    batch_action_collection.find(ids).each do |reservation|
      reservation.confirm
    end
    redirect_back fallback_location: admin_reservations_path,
      alert: "Successfully confirmed #{ids.count} reservations"
  end

  batch_action :close, confirm: 'Are you sure you want to close these reservations?' do |ids|
    batch_action_collection.find(ids).each do |reservation|
      reservation.close
    end
    redirect_back fallback_location: admin_reservations_path,
      alert: "Successfully closed #{ids.count} reservations"
  end

  index do
    selectable_column
    column :name
    column :number_of_guests
    column 'Date', :date_time, sortable: :date_time do |reservation|
      reservation.date_time.strftime('%B %-d, %Y %I:%M %P')
    end
    column :status do |reservation|
      case reservation.status
      when 'Pending'
        status_tag reservation.status, class: 'warning'
      when 'Confirmed'
        status_tag reservation.status, class: 'ok'
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

  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :number_of_guests
      row 'Date', :date_time do |reservation|
        reservation.date_time.strftime('%B %-d, %Y %I:%M %P')
      end
      row :message
      row :status do |reservation|
        case reservation.status
        when 'Pending'
          status_tag reservation.status, class: 'warning'
        when 'Confirmed'
          status_tag reservation.status, class: 'ok'
        when 'Closed'
          status_tag reservation.status
        end
      end
      row :created_at do |reservation|
        reservation.created_at.strftime('%B %-d, %Y %I:%M %P')
      end
      row :updated_at do |reservation|
        reservation.updated_at.strftime('%B %-d, %Y %I:%M %P')
      end
    end
    active_admin_comments
  end

  form do |f|
    inputs do
      input :name
      input :email
      input :phone
      input :number_of_guests, as: :select, collection: (10..50).step(10).to_a,
                                            prompt: 'How Many?'
      input :date_time, label: 'Date', 
                        start_year: DateTime.current.year,  
                        order: [:month, :day, :year],
                        prompt: true,
                        include_blank: false
      input :message
      input :status, as: :select, collection: ['Pending', 'Confirmed', 'Closed'],
                                  include_blank: false
    end

    actions
  end

  permit_params :name,
                :email,
                :phone,
                :number_of_guests,
                :date_time,
                :message,
                :status
end
