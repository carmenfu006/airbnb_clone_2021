class AddColumnsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :paid_at, :datetime
    add_column :bookings, :charge_id, :string
  end
end
