class Movie < ApplicationRecord
	has_many :votes
	def voted_by? user
		votes.find_by_user_id user[:id]
	end

	def self.tfidf  condition
		columns = %w[Title Genre Description Director Actors]

		filtered = where(condition)
		if filtered.count==0
			return []
		end
		word_list = [
			filtered.pluck('Title').map{|t| t.split(" ")},
			filtered.pluck('Genre').map{|g| g[1..-2].split(",")},
			filtered.pluck('Description').map{|d| d[1..-2].split(" ")},
			filtered.pluck('Director'),
			filtered.pluck('Actors').map{|a| a[1..-2].split(",")}
		].flatten

		word_order = word_list.map do |word|
			columns.map do |column|
				"1.0*(#{column} like '%#{word}%')/(select 1+sum(#{column} like '%#{word}%') from movies)"
			end.join("+")
		end.join("+")



		return Movie.all.order(word_order+" desc").offset(filtered.size)
	end
end
