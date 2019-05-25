class CleanMatchesTable < ActiveJob::Base

	def perform
    matches = Match.where("starts_at < ?", Time.now - 30.days)
    matches.destroy_all
	end
end