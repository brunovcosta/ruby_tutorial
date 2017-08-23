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
