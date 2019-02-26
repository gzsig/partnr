class CreateDealUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :deal_users do |t|
      t.references :user, foreign_key: true
      t.references :deal, foreign_key: true
      t.boolean :track_use
      t.boolean :other_drivers

      t.timestamps
    end
  end
end
