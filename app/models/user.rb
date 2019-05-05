class User < ApplicationRecord

	has_many :matches

  def self.from_omniauth auth
  	info = auth['info']
    # Convert from 64-bit to 32-bit
    user = find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
    user.nickname = info['nickname']
    user.avatar_url = info['image']
    user.profile_url = info['urls']['Profile']
    user.save!
    user
  end

	def get_matches duration: 30.days, after_id: nil
		matches = Dota.api.matches(player_id: self.uid, after: after_id)
		matches.each do |m|
			player = m.raw["players"].find { |player| player["account_id"].to_s == self.uid }
			player["player_slot"] < 5 ? slot = :radiant : slot = :dire 
			break unless (Time.now - m.starts_at) <= duration	
			self.matches.create(id: m.id, user_id: uid, slot: slot, winner: m.winner, hero_id: player["hero_id"]) if m.id != after_id
		end
		get_matches(after_id: matches.last.id) if Time.now - matches.last.starts_at < duration && matches.size == 100
	end

	def count_win_rates
		matches = self.matches
		heros = Hero.all
		win_rates = Hash.new
		heros.each { |hero| win_rates[hero.id] = {name: hero.localized_name, pick: 0,win: 0} }
		matches.each do |match|
			win_rates[match.hero_id][:pick] += 1
			win_rates[match.hero_id][:win] += 1 if match.winner == match.slot
		end
		win_rates
	end
end
