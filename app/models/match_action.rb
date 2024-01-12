class MatchAction < ApplicationRecord
  belongs_to :match
  belongs_to :team, optional: true
end
