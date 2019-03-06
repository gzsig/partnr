class AddStepToPartners < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :step, :integer, default: 0
  end
end
