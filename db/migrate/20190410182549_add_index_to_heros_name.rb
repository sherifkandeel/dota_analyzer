class AddIndexToHerosName < ActiveRecord::Migration[5.2]
  def change
    add_index :heros, :localized_name
  end
end
