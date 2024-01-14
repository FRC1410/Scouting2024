require 'csv'

MatchAction.destroy_all
Match.destroy_all
5.times do
  Match.create(match_action: MatchAction.new)
end

CSV.open(Rails.root.join('db', 'fixtures', 'frc_teams.csv'), 'r', headers: true).each do |record|
  values = record.to_h.symbolize_keys
  values.delete(:blank)
  Team.find_or_create_by(values)
end