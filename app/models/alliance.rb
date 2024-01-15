class Alliance < ApplicationRecord
  enum color: [ :red, :blue ]

  has_many :alliance_teams, dependent: :destroy
  has_many :teams, through: :alliance_teams
end
