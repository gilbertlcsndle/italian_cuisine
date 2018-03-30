ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Today' do
          if Reservation.today.any?
            table_for Reservation.today.limit(5) do
              column :name do |reservation|
                link_to reservation.name, admin_reservation_path(reservation)
              end
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
            end

            strong { link_to 'View All', admin_reservations_path }
          else
            strong { 'No reservations today.' }
          end
        end
      end

      column do
        panel 'Upcoming' do
          table_for Reservation.upcoming.limit(5) do
            column :name do |reservation|
              link_to reservation.name, admin_reservation_path(reservation)
            end
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
          end

          strong { link_to 'View All', admin_reservations_path }
        end
      end
    end

    columns do
      column do
        panel 'Pending' do
          table_for Reservation.pending.limit(5) do
            column :name do |reservation|
              link_to reservation.name, admin_reservation_path(reservation)
            end
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
          end

          strong { link_to 'View All', admin_reservations_path }
        end
      end
    end
  end
end
