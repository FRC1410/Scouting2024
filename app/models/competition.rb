require 'csv'
class Competition < ApplicationRecord
  has_many :matches, dependent: :destroy, autosave: true

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
end
