class AddStepToPartners < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :step, :integer
  end
end
