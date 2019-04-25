class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :winner
      t.string :slot
      t.integer :hero_id
      t.integer :user_id

      t.timestamps
    end
  end
end
