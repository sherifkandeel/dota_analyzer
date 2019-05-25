class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :winner
      t.datetime :starts_at
      
      t.timestamps
    end
    add_index :matches, :starts_at
  end
end
