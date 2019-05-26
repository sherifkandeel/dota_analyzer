class Player < ApplicationRecord
  validates :user_id, presence: true
  validates :match_id, presence: true
  validates :hero_id, presence: true
end
