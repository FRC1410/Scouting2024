require 'csv'

TeamScoreSheet.destroy_all
Match.destroy_all
Alliance.destroy_all
Competition.destroy_all
utah = Competition.create(name: 'Utah')
Competition.create(name: 'Houston')

CSV.open(Rails.root.join('db', 'fixtures', 'frc_teams.csv'), 'r', headers: true).each do |record|
  values = record.to_h.symbolize_keys
  values.delete(:blank)
  Team.find_or_create_by(values)
end

Match.create!(
  competition: utah,
  match_number: 1,
  red_alliance: Alliance.new(
    color: :red,
    teams: Team.where(number: [1, 1410, 1619]).all
  ),
  blue_alliance: Alliance.new(
    color: :blue,
    teams: Team.where(number: [1339, 2240, 2945]).all
  )
)
TeamLog.destroy_all
TeamLog.create!(
  log: <<~LOG,
    King in the North. When you play the game of thrones, you win or you die. What is dead may never die. A forked purple lightning bolt, on black field speckled with four-pointed stars. The War of the 5 kings. More pigeon pie, please. The winds of Winter. Forgive my manners. I don't see many ladies these days. Lucky for the ladies. The War of the 5 kings. As High as Honor. Pay the iron price. You know nothing, Jon Snow. Words are like wind. The winds of Winter. Fire and blood. Winter is coming. The bear and the maiden fair. May the Father judge him justly. The winds of Winter. Our Sun Shines Bright. A forked purple lightning bolt, on black field speckled with four-pointed stars. The War of the 5 kings. Forgive my manners. I don't see many ladies these days. Lucky for the ladies. May the Father judge him justly. The winds of Winter. As High as Honor. Can a man still be brave if he’s afraid? That is the only time a man can be brave.A Lannister always pays his debts. The night is dark and full of terrors. A Lannister always pays his debts. The tourney of Ashford Meadows. The night is dark and full of terrors. A Lannister always pays his debts. House Tarly of Horn Hill A forked purple lightning bolt, on black field speckled with four-pointed stars. Our Sun Shines Bright. The rains of castamere. The North remembers. Words are like wind. And now his watch is ended. Dunc the Lunk, thick as a castle wall. The winds of Winter. May the Father judge him justly. All men must die. Winter is coming. A Lannister always pays his debts. And now his watch is ended. House Tarly of Horn Hill House Tarly of Horn Hill The battle of the redgrass field
  LOG
  team: Team.find_by(number: 1)
)
