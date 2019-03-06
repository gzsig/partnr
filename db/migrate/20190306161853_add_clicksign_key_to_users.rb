class AddClicksignKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :clicksign_key, :string
  end
end
