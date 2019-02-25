class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.string :deal_status
      t.references :car, foreign_key: true
      t.references :user_1, foreign_key: { to_table: :users }
      t.references :user_2, foreign_key: { to_table: :users }
      t.references :user_3, foreign_key: { to_table: :users }
      t.references :user_4, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
