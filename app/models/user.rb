class User < ActiveRecord::Base
  has_many :groups
  has_many :joins, dependent: :destroy
  has_many :groups_joined, through: :joins, source: :group
  has_many :choices
  has_many :picks, through: :choices
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true
end
