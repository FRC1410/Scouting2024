class Alliance < ApplicationRecord
  enum color: [ :red, :blue ]

  has_many :team_score_sheets, dependent: :destroy
  has_many :teams, through: :team_score_sheets
end
