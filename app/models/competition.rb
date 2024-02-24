require 'csv'
class Competition < ApplicationRecord
  has_many :matches, dependent: :destroy, autosave: true
  has_many :competition_teams, dependent: :destroy, autosave: true
  has_many :teams, through: :competition_teams

  def create_matches_from_file(file)
    CSV.open(file, 'r', headers: true).each do |record|
      values = record.to_h.symbolize_keys
      values.values_at(:Red1, :Red2, :Red3)
      teams = Team.where(number: values.values_at(:Red1, :Red2, :Red3)).all
      alliance_red = Alliance.create!(
        color: :red,
        teams: teams
      )
      alliance_blue = Alliance.create!(
        color: :blue,
        teams: Team.where(number: values.values_at(:Blue1, :Blue2, :Blue3))
      )
      begin
        Match.create!(
          competition: self,
          match_number: values[:Match_Number],
          red_alliance: alliance_red,
          blue_alliance: alliance_blue
        )
      rescue
        return false
      end
    end

    true
  end

  def create_teams_from_file(file)
    team_numbers = []
    CSV.foreach(file, 'r', headers: true) {|row| team_numbers << row[0].to_i}
    existing_teams = Team.where(number: team_numbers).pluck(:number)
    missing_teams = team_numbers - existing_teams

    if missing_teams.count > 0
      return {success: false, missing_teams: missing_teams }
    end

    teams = Team.where(number: team_numbers)
    self.update(teams: teams)

    {success: true, missing_teams: missing_teams }
  end
end