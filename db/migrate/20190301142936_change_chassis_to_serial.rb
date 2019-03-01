class Changeserial_numberToSerial < ActiveRecord::Migration[5.2]
  def change
    rename_column :goods, :serial_number, :serial_number
  end
end
