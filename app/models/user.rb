class User < ApplicationRecord
	has_and_belongs_to_many :matches
	validates :uid, presence: true, uniqueness: true

  def self.from_omniauth auth
  	info = auth['info']
    user = find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
    user.nickname = info['nickname']
    user.avatar_url = info['image']
    user.profile_url = info['urls']['Profile']
    user.save!
    user
  end

	def get_matches duration: 30.days, after_id: nil
		Api.load_user_matches(self.uid).each do |m|
			break if (Time.now - m.starts_at) > duration || self.matches.exists?(m.id)
			match = Match.find_or_create_by(id: m.id, winner: m.winner, starts_at: m.starts_at)
			self.matches << match
			m.raw["players"].each { |p|	match.add_player p} if match.players.empty?
		end
	end

	def table_data
		matches = self.matches.where("starts_at > ?", Time.now - 30.days)
		win_rates = count_win_rates matches
		{headers_data: table_headers, body_data: win_rates, totals: {your_pick: win_rates.to_a.sum { |h| h.second[:your_pick]}}}
	end

	def count_win_rates matches
		win_rates = Hash.new
		Hero.all.each { |hero| win_rates[hero.id] = {name: hero.localized_name, your_pick: 0, your_win: 0} }
		matches.each do |match|
			player = match.get_player self
			next if player.nil?
			win_rates[player.hero_id][:your_pick] += 1
			win_rates[player.hero_id][:your_win] += 1 if match.winner == player.slot
		end
		win_rates
	end

	def table_headers
		[["Your Pick", "your_pick", "Y P"], ["Your Win", "your_win", "Y W"]]
	end
end
