class Prize < ApplicationRecord
  has_many :prizes_users
  has_many :users, through: :prizes_users
end
