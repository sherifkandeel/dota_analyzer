class User < ApplicationRecord

	has_many :matches
	validates :uid, presence: true, uniqueness: true

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
			break unless (Time.now - m.starts_at) <= duration	
			player = get_player m
			if Match.exists?(m.id)
				break
			else
				self.matches.create(id: m.id, 
														user_id: uid, 
														slot: get_slot(m), 
														winner: m.winner, 
														starts_at: m.starts_at,
														hero_id: player["hero_id"]
														) 
			end
		end
		get_matches(after_id: matches.last.id) if Time.now - matches.last.starts_at < duration && matches.size == 100
	end

	def get_player match
		player = match.raw["players"].find { |player| player["account_id"].to_s == self.uid }
	end

	def get_slot match
		player = get_player match
		player["player_slot"] < 5 ?  :radiant : :dire 
	end

	def table_data
		matches = self.matches.where("starts_at > ?", Time.now - 30.days)
		heros = Hero.all
		data = Hash.new
		win_rates = Hash.new
		headers = [["Your Pick", "your_pick", "Y P"], ["Your Win", "your_win", "Y W"]]
		heros.each { |hero| win_rates[hero.id] = {name: hero.localized_name, your_pick: 0, your_win: 0} }
		matches.each do |match|
			win_rates[match.hero_id][:your_pick] += 1
			win_rates[match.hero_id][:your_win] += 1 if match.winner == match.slot
		end
		data[:headers_data] = headers
		data[:body_data] = win_rates
		data[:totals] = {:your_pick => win_rates.to_a.sum { |h| h.second[:your_pick]}}
		data
	end
end
