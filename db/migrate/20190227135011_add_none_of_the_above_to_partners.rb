class AddNoneOfTheAboveToPartners < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :none_of_the_above, :boolean
  end
end
