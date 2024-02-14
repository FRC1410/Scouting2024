require 'csv'

TeamScoreSheet.destroy_all
Match.destroy_all
Alliance.destroy_all
Competition.destroy_all
utah = Competition.create(name: 'Utah')
Competition.create(name: 'Houston')
TeamLog.destroy_all
Team.destroy_all
User.destroy_all

User.create!(
  first_name: 'The',
  last_name: 'Kraken',
  initials: 'TJ',
  email: 'tj@example.com',
)

CSV.open(Rails.root.join('db', 'fixtures', 'frc_teams.csv'), 'r', headers: true).each do |record|
  values = record.to_h.symbolize_keys
  values.delete(:blank)
  if !values[:name].match?('Off-Season Demo Team')
    Team.find_or_create_by(values)
  end
end

200.times do |match_number|
  alliance_red = Alliance.create!(
    color: :red,
    teams: Team.order("RANDOM()").limit(3)
  )
  alliance_blue = Alliance.create!(
    color: :blue,
    teams: Team.order("RANDOM()").limit(3)
  )
  Match.create!(
    competition: utah,
    match_number: match_number+1,
    red_alliance: alliance_red,
    blue_alliance: alliance_blue
  )

  bools = [true, false]

  (alliance_red.team_score_sheets + alliance_blue.team_score_sheets).each do |team_score_sheet|
    team_score_sheet.update!(
      leave: bools.sample,
      score_speaker_auto: Random.rand(30),
      score_amp_auto: Random.rand(30),
      score_speaker: Random.rand(30),
      score_amp: Random.rand(30),
      score_trap: Random.rand(30),
      score_speaker_amplified: Random.rand(30),
      park: bools.sample,
      onstage: bools.sample,
      harmony: bools.sample,
      defended: bools.sample,
      dead_on_field: bools.sample,
      foul: Random.rand(3),
    )
  end
end

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


