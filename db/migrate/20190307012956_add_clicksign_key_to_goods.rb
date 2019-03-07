class AddClicksignKeyToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :clicksign_key, :string
  end
end
