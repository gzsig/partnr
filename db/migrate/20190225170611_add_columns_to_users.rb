class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :phone_number, :string
    add_column :users, :CPF, :string
    add_column :users, :occupation, :string
    add_column :users, :address, :string
  end
end
