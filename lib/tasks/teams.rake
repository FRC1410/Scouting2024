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

  task update_2024: :environment do
    existing_teams = Team.pluck(:number)
    CSV.open(Rails.root.join('db', 'fixtures', '2024teams.csv'), 'r', headers: true).each do |record|

      values = record.to_h.symbolize_keys
      if existing_teams.include? values[:number].to_i
        next
      else
        p values
        Team.create(values)
      end
    end
  end
end