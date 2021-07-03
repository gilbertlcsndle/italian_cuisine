class RemoveMessageFromReservations < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :message, :text
  end
end
