class Alliance < ApplicationRecord
  enum color: [ :red, :blue ]

  has_many :team_score_sheets, dependent: :destroy, autosave: true
  has_many :teams, through: :team_score_sheets

  validates_size_of :teams, is: 3, message: "must have 3 selected"
end
