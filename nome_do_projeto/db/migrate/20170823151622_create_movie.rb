class CreateMovie < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :Rank
      t.string :Title
      t.string :Genre
      t.string :Description
      t.string :Director
      t.string :Actors
      t.string :Year
      t.string :Runtime
      t.string :Rating
      t.string :Votes
      t.string :Revenue
      t.string :Metascore
    end
  end
end
