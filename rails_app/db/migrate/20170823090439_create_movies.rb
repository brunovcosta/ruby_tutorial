class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.integer :Rank
      t.string :Title
      t.string :Genre
      t.string :Description
      t.string :Director
      t.string :Actors
      t.integer :Year
      t.integer :Runtime
      t.decimal :Rating
      t.integer :Votes
      t.decimal :Revenue
      t.integer :Metascore

      t.timestamps
    end
  end
end
