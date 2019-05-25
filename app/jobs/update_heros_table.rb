class UpdateHerosTable < ActiveJob::Base

	def perform
		heros = parse_response RestClient.get 'https://api.opendota.com/api/herostats'
		Hero.destroy_all
		Hero.create! heros
	end
	
	def parse_response response
		heros = JSON.parse response
		heros.map do |hero|
			{localized_name: hero["localized_name"],
			 herald_pick:    hero["1_pick"].to_i,
			 herald_win:     hero["1_win"].to_i,
			 guardian_pick:  hero["2_pick"].to_i,
			 guardian_win:   hero["2_win"].to_i,
			 crusader_pick:  hero["3_pick"].to_i,
			 crusader_win:   hero["3_win"].to_i,
			 archon_pick:    hero["4_pick"].to_i,
			 archon_win:     hero["4_win"].to_i,
			 legend_pick:    hero["5_pick"].to_i,
			 legend_win:     hero["5_win"].to_i,
			 ancient_pick:   hero["6_pick"].to_i,
			 ancient_win:    hero["6_win"].to_i,
			 divine_pick:    hero["7_pick"].to_i,
			 divine_win:     hero["7_win"].to_i,
			 immortal_pick:  hero["8_pick"].to_i,
			 immortal_win:   hero["8_win"].to_i,
			 pro_pick:       hero["pro_pick"].to_i,
			 pro_win:        hero["pro_win"].to_i,
			 pro_ban:        hero["pro_ban"].to_i,
			 id:             hero["id"]}
		end
	end
end