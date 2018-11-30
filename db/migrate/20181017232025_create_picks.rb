class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :week
      t.string :team
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
