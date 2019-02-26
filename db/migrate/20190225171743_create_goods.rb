class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string :brand
      t.string :model
      t.integer :model_year
      t.integer :fabrication_year
      t.string :chassis
      t.string :licens_plate
      t.string :kilometers
      t.string :price
      t.string :color
      t.string :specs
      t.string :facts
      t.string :version
      t.string :good_type
      t.string :photo_one
      t.string :photo_two
      t.string :photo_three
      t.string :photo_four
      t.string :video

      t.timestamps
    end
  end
end
