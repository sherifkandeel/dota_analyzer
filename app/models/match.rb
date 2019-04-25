class Match < ApplicationRecord
  has_one    :hero
	belongs_to :user
end
