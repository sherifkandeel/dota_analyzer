class Match < ApplicationRecord
  has_many :players, dependent: :destroy
  has_and_belongs_to_many :users
  validates    :id, :winner, :starts_at, presence: true

  def add_player p
    return if p["account_id"] == 4294967295
    self.players.create(user_id: p["account_id"].to_s, hero_id: p["hero_id"], slot: p["player_slot"] < 5 ? :radiant : :dire)
  end

  def get_player user
		self.players.find {|player| player.user_id == user.uid}
	end
end
