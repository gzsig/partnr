class AddSpecificationsToPartners < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :numberber_of_passengers, :integer
    add_column :partners, :km_month, :integer
    add_column :partners, :frenquency_month, :integer
    add_column :partners, :for_work, :boolean
  end
end
