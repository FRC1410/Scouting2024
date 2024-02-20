require 'csv'

namespace :teams do
  task create: :environment do
    raise "Teams already exist" unless Team.count < 1

    CSV.open(Rails.root.join('db', 'fixtures', 'frc_teams.csv'), 'r', headers: true).each do |record|
      values = record.to_h.symbolize_keys
      values.delete(:blank)
      if !values[:name].match?('Off-Season Demo Team')
        Team.find_or_create_by(values)
      end
    end
  end
end