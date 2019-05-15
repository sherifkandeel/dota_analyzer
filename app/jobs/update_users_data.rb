class UpdateUsersData < ActiveJob::Base

	def perform
    users = User.all
    users.each { |user| user.get_matches}
  end
end