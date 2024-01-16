class Team < ApplicationRecord
  def number_and_name
    "#{number} #{name}"
  end
end
