require 'csv'

Competition.destroy_all
Competition.create(name: 'Utah')
Competition.create(name: 'Houston')

CSV.open(Rails.root.join('db', 'fixtures', 'frc_teams.csv'), 'r', headers: true).each do |record|
  values = record.to_h.symbolize_keys
  values.delete(:blank)
  Team.find_or_create_by(values)
end

MatchAction.destroy_all
TeamScoreSheet.destroy_all
Match.destroy_all
Alliance.destroy_all
Match.create(
  match_action: MatchAction.new,
  red_alliance: Alliance.new(
    color: :red,
    teams: Team.where(number: [1, 1410, 1619]).all
  ),
  blue_alliance: Alliance.new(
    color: :red,
    teams: Team.where(number: [1339, 2240, 2945]).all
  )
)
