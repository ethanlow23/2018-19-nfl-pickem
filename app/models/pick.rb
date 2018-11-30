class Pick < ActiveRecord::Base
  belongs_to :game
  has_many :choices
  has_many :users, through: :choices
end
