class CreateJoinTableUsersMatches < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :matches do |t|
      t.index [:user_id, :match_id] , :unique=> true
    end
  end
end
