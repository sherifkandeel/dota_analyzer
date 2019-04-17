class HeroCronJob < ActiveJob::Base
	def perform
		response = RestClient.get 'https://api.opendota.com/api/herostats'
		response = JSON.parse response
		Hero.create_heros response
  end
end