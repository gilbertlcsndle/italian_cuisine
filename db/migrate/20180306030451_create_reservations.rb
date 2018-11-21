class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :number_of_guests
      t.datetime :date_time
      t.text :message

      t.timestamps
    end
  end
end
