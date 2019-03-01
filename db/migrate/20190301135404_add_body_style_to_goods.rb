class AddBodyStyleToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :body_style, :string
  end
end
