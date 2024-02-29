class Prize < ApplicationRecord
  has_many :prizes_users, dependent: :destroy
  has_many :users, through: :prizes_users
end
