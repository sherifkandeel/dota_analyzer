class AddIndexToHerosName < ActiveRecord::Migration[5.2]
  def change
    add_index :heros, :name
  end
end
