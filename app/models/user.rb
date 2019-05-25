class User < ApplicationRecord
	has_and_belongs_to_many :matches
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
		ApiCalls.get_user_matches(self.uid).each do |m|
			break if (Time.now - m.starts_at) > duration
			match = Match.find_or_create_by(id: m.id, winner: m.winner, starts_at: m.starts_at)
			unless self.matches.exists?(m.id)
				self.matches << match
			else #This and all next matches are already saved
				break
			end
			if(match.players.empty?)
				m.raw["players"].each do |p|
					if p["account_id"] != 4294967295
						match.players.create(user_id: p["account_id"].to_s, hero_id: p["hero_id"], slot: p["player_slot"] < 5 ? :radiant : :dire)
					end
				end
			end
		end
	end

	def table_data
		matches = self.matches.where("starts_at > ?", Time.now - 30.days)
		heros = Hero.all
		data = Hash.new
		win_rates = Hash.new
		headers = [["Your Pick", "your_pick", "Y P"], ["Your Win", "your_win", "Y W"]]
		heros.each { |hero| win_rates[hero.id] = {name: hero.localized_name, your_pick: 0, your_win: 0} }
		matches.each do |match|
			player = get_player match
			win_rates[player.hero_id][:your_pick] += 1
			win_rates[player.hero_id][:your_win] += 1 if match.winner == player.slot
		end
		data[:headers_data] = headers
		data[:body_data] = win_rates
		data[:totals] = {:your_pick => win_rates.to_a.sum { |h| h.second[:your_pick]}}
		data
	end

	def get_player match
		match.players.find {|player| player.user_id == self.uid}
	end
end
