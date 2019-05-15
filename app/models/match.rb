class Match < ApplicationRecord
  has_one    :hero
  belongs_to :user
  validates :user_id, :id, :slot, :winner, :starts_at, :hero_id, presence: true
end
