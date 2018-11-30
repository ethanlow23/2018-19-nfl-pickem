class RemoveIncorrectFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :incorrect, :integer
  end
end
