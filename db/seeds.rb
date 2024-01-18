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
        # Amantem lacerare Peloro succinctae

    ## A ferar una horret matrem perdiderint indigenae

    Lorem markdownum, visa **quod trahens secundo**. Lacerum nec dedit trahebat
    formae: totis arte habentem prodes nexilibusque Iovis praecordia! Inpia solum
    nati animosa, sanguine valens adnuimusque fertque fuerat. Neque victrices fumos!

        ecc = rupVrml(apple_directx * clientIcq, sambaTableAcl(sramWindows,
                newsgroup_key_day + padTiff, leak));
        thermistor_buffer(and, mode + non_halftone);
        var netbiosMonitor = station.vramGateway.webmaster(-5 + errorOf, ups_mode) +
                1;

    Quos iam celebres pressit, Arcas *quibus errabat acumina* linguaque ante femur.
    Moratur graves enim, quo ora narrare color herbas
    consultaque obortae tunc sit.
  LOG
  team: Team.find_by(number: 1)
)
