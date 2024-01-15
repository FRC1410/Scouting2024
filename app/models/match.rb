class Match < ApplicationRecord
  has_one :match_action
  belongs_to :red_alliance, -> { where(color: :red) }, class_name: "Alliance", dependent: :destroy
  belongs_to :blue_alliance, -> { where(color: :blue) }, class_name: "Alliance", dependent: :destroy
end
