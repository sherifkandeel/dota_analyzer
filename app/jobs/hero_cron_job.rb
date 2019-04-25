class HeroCronJob < ActiveJob::Base

	def perform
		heros = parse_response RestClient.get 'https://api.opendota.com/api/herostats'
		Hero.destroy_all
		Hero.create! heros
	end
	
	def parse_response response
		heros = JSON.parse response
		heros.map do |hero|
			{localized_name: hero["localized_name"],
			 herald_pick:    hero["1_pick"],
			 herald_win:     hero["1_win"],
			 guardian_pick:  hero["2_pick"],
			 guardian_win:   hero["2_win"],
			 crusader_pick:  hero["3_pick"],
			 crusader_win:   hero["3_win"],
			 archon_pick:    hero["4_pick"],
			 archon_win:     hero["4_win"],
			 legend_pick:    hero["5_pick"],
			 legend_win:     hero["5_win"],
			 ancient_pick:   hero["6_pick"],
			 ancient_win:    hero["6_win"],
			 divine_pick:    hero["7_pick"],
			 divine_win:     hero["7_win"],
			 immortal_pick:  hero["8_pick"],
			 immortal_win:   hero["8_win"],
			 pro_pick:       hero["pro_pick"],
			 pro_win:        hero["pro_win"],
			 pro_ban:        hero["pro_ban"],
			 id:             hero["id"]}
		end
	end
end