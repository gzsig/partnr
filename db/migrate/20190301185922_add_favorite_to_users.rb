class AddFavoriteToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorite, :string
  end
end
