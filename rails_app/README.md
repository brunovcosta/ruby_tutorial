# Rails
## Pré requisitos
 - Ruby
 - Rails
 - [Dataset IMDB](https://www.kaggle.com/PromptCloudHQ/imdb-data)
## Passo a passo
### Setup inicial
#### Aplicação em Rails

```
rails new filmes
```

#### Scaffold de Movies
```
rails g scaffold movies Rank:integer Title Genre Description Director Actors Year:integer Runtime:integer Rating:decimal Votes:integer Revenue:decimal Metascore:integer

rails g scaffold users login password

rails g scaffold votes user:references movie:references positive:boolean
```

#### Controllers com a home
```
rails g controller extra home
```

#### Migração do banco de dados
```
rake db:migrate
```

#### Colocar o arquivo CSV na pasta db
**IMPORTANTE** - apagar os parenteses da primeira linha
```
data.csv  development.sqlite3  migrate/  schema.rb  seeds.rb
```

#### db/seed.rb
```
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
```
#### config/routes.rb
```
Rails.application.routes.draw do
  resources :votes
  resources :users
  resources :movies
  root "extra#home"
  post "/login" => "users#login"
end
```


#### app/views/extra/home.html.erb
```
<% if session[:user] %>
	<%= link_to "iniciar",movies_path %>
<% else %>
	<h2>Faça login para acessar</h2>
	<%= form_for :user, url: "/login" do |f| %>
		<%= f.label :login %>
		<%= f.text_field :login %>
		<%= f.label :senha %>
		<%= f.password_field "password"%>
		<br>
		<%= f.submit :login %>
	<% end %>
	<%= link_to "criar conta",new_user_path %>
<% end %>
```

#### app/controllers/users_controller.rb::login
realizar login
```
def login
	@user = User.find_by(login: params[:user][:login],password: params[:user][:password])
	if @user
		session[:user] = @user
		redirect_to :movies
	else
		redirect_to :back
	end
end
```

#### app/controllers/users_controller.rb::create
permanecer logado
```
def create
  @user = User.new(user_params)

  respond_to do |format|
	  if @user.save
		  format.html { redirect_to @user, notice: 'User was successfully created.' }
		  format.json { render :show, status: :created, location: @user }
		  session[:user] = @user
	  else
		  format.html { render :new }
		  format.json { render json: @user.errors, status: :unprocessable_entity }
	  end
  end
end
```

#### app/views/users/_form.html.erb
Troque o input de senha de text_field para password_field
```
<%= form_for(user) do |f| %> 
  <% if user.errors.any? %> 
    <div id="error_explanation"> 
      <h2><%= pluralize(user.errors.count, "error") %> prohibited this user from being saved:</h2> 
 
      <ul> 
      <% user.errors.full_messages.each do |message| %>
        <li><%= message %></li> 
      <% end %> 
      </ul> 
    </div> 
  <% end %> 
 
  <div class="field"> 
    <%= f.label :login %> 
    <%= f.text_field :login %> 
  </div> 
 
  <div class="field"> 
    <%= f.label :password %> 
    <%= f.password_field :password %> 
  </div> 
 
  <div class="actions"> 
    <%= f.submit %> 
  </div> 
<% end %> 
```

#### app/models/movie.rb
```
class Movie < ApplicationRecord
	def self.tfidf  condition
		columns = %w[Title Genre Description Director Actors]

		filtered = where(condition)
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


		number_order = %[Year Runtime Rating Votes Revenue Metascore].map do |column|

		end

		return Movie.all.order(word_order+" desc").offset(filtered.size)
	end
end
```

## Próximos passos
- Usar os valores numéricos
- Não guardar senha no banco de dados

