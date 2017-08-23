# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 
regex = /(".*?"|[^",\s]+)(?=\s*,|\s*$)/
tabela = File.open(File.join(Rails.root, 'db','data.csv')).read.split("\r\n").map{|linha| linha.scan(regex).flatten}
lista = tabela[1..-1].map{|l|l.map.with_index{|c,i|[tabela[0][i],c]}.to_h}
for filme in lista
	begin
		Movie.create filme
		print "."
	rescue
		print "E"
	end
end
