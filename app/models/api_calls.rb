class ApiCalls
  def self.get_user_matches id, after_id = nil, duration = 30.days
    matches = Dota.api.matches(player_id: id, after: after_id)
    if Time.now - matches.last.starts_at < duration && matches.size == 100
      matches << ApiCalls.get_user_matches(id, matches.last.id - 1) 
    end
    matches.flatten
  end
end