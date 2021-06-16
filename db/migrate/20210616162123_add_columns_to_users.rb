class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    # add_column :table_name, :column_name, :column_type, :column_options
    add_column :users, :fullname, :string
    add_column :users, :username, :string
    add_column :users, :birth_date, :date
  end
end
