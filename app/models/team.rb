class Team < ApplicationRecord
  has_many :team_logs
  def number_and_name
    "#{number} #{name}"
  end
end
