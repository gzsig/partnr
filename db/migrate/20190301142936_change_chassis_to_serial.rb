class ChangeChassisToSerial < ActiveRecord::Migration[5.2]
  def change
    rename_column :goods, :chassis, :serial_number
  end
end
