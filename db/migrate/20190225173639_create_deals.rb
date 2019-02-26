class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.string :deal_status
      t.references :car, foreign_key: true
      t.timestamps
    end
  end
end
