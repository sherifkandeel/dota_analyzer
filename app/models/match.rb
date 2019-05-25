class Match < ApplicationRecord
  has_many :players, dependent: :destroy
  has_and_belongs_to_many :users #, -> { distinct }
  validates    :winner, :starts_at, presence: true
end
