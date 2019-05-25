class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string  :slot
      t.integer :hero_id
      t.string  :user_id
      t.references :match, foreign_key: true

      t.timestamps
    end
    add_index :players, [:match_id, :user_id], unique: true
  end
end
