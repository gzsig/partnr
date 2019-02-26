class RemoveSpecsFromGoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :goods, :specs, :string
  end
end
