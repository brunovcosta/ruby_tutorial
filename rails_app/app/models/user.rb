class User < ApplicationRecord
	has_many :movies, through: :votes
	has_many :votes
end
