class AddIndexToMatchesStartsAt < ActiveRecord::Migration[5.2]
  def change
    add_index :matches, :starts_at
  end
end
