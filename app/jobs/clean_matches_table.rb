class CleanMatchesTable < ActiveJob::Base

	def perform
    matches = Match.where("starts_at < ?", Time.now - 30.days)
    matches.delete_all
	end
end