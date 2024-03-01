require 'csv'

class Competition < ApplicationRecord
  has_many :matches, dependent: :destroy, autosave: true
  has_many :competition_teams, dependent: :destroy, autosave: true
  has_many :teams, through: :competition_teams

  def create_matches_from_file(file)
    CSV.open(file, 'r', headers: true).each do |record|
      values = record.to_h
      red1_teams = Team.find_by(number: values["Red1"])
      red2_teams = Team.find_by(number: values["Red2"])
      red3_teams = Team.find_by(number: values["Red3"])

      alliance_red = Alliance.new(
        color: :red,
      )

      alliance_red.teams << red1_teams
      alliance_red.teams << red2_teams
      alliance_red.teams << red3_teams

      alliance_red.save!

      blue1_teams = Team.find_by(number: values["Blue1"])
      blue2_teams = Team.find_by(number: values["Blue2"])
      blue3_teams = Team.find_by(number: values["Blue3"])

      alliance_blue = Alliance.new(
        color: :blue,
      )

      alliance_blue.teams << blue1_teams
      alliance_blue.teams << blue2_teams
      alliance_blue.teams << blue3_teams

      alliance_blue.save!

      begin
        Match.create!(
          competition: self,
          match_number: values.fetch(values.keys.first),
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
    CSV.foreach(file, 'r', headers: true) { |row| team_numbers << row[0].to_i }
    existing_teams = Team.where(number: team_numbers).pluck(:number)
    missing_teams = team_numbers - existing_teams

    if missing_teams.count > 0
      return { success: false, missing_teams: missing_teams }
    end

    teams = Team.where(number: team_numbers)
    self.update(teams: teams)

    { success: true, missing_teams: missing_teams }
  end
end