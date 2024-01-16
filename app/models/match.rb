class Match < ApplicationRecord
  after_create_commit -> {
    broadcast_prepend_to "matches",
                         partial: "matches/match",
                         locals: {
                           match: self,
                           competition: self.competition,
                           new: "new"
                         },
                         target: "matches" }
  belongs_to :competition
  belongs_to :red_alliance, -> { where(color: :red) }, class_name: "Alliance", dependent: :destroy, autosave: true
  belongs_to :blue_alliance, -> { where(color: :blue) }, class_name: "Alliance", dependent: :destroy, autosave: true

  validates_presence_of :match_number

  def red_alliance_teams
    teams = red_alliance.try(&:teams) || []
    teams.map { |t| t[:id] }
  end

  def blue_alliance_teams
    teams = blue_alliance.try(&:teams) || []
    teams.map { |t| t[:id] }
  end
end
