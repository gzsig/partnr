class AddSatusToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :status, :boolean, default: false
  end
end
