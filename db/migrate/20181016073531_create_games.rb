class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :week
      t.string :home
      t.string :away
      t.integer :away_score
      t.integer :home_score

      t.timestamps null: false
    end
  end
end
