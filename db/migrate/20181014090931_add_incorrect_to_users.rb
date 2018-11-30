class AddIncorrectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :incorrect, :integer
  end
end
