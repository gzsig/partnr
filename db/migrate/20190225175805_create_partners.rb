class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.references :user, foreign_key: true
      t.references :good, foreign_key: true
      t.boolean :track_use
      t.boolean :other_drivers

      t.timestamps
    end
  end
end
