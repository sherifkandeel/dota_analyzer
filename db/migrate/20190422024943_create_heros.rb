class CreateHeros < ActiveRecord::Migration[5.2]
  def change
    create_table :heros do |t|
      t.string :localized_name
      t.integer :herald_pick
      t.integer :herald_win
      t.integer :guardian_pick
      t.integer :guardian_win
      t.integer :crusader_pick
      t.integer :crusader_win
      t.integer :archon_pick
      t.integer :archon_win
      t.integer :legend_pick
      t.integer :legend_win
      t.integer :ancient_pick
      t.integer :ancient_win
      t.integer :divine_pick
      t.integer :divine_win
      t.integer :immortal_pick
      t.integer :immortal_win
      t.integer :pro_pick
      t.integer :pro_win
      t.integer :pro_ban

      t.timestamps
    end
  end
end
