class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :senha
    end
  end
end
