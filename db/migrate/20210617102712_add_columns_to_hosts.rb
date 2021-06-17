class AddColumnsToHosts < ActiveRecord::Migration[6.1]
  def change
    add_column :hosts, :fullname, :string
    add_column :hosts, :username, :string
    add_column :hosts, :birth_date, :date
  end
end
