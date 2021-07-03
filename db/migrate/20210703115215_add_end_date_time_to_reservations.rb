class AddEndDateTimeToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :end_date_time, :datetime
  end
end
