class TeamScoreSheet < ApplicationRecord
  belongs_to :team
  belongs_to :user, optional: true

  def user_initials
    if self.user.present?
      "(#{self.user.initials})"
    else
      ""
    end
  end

  def locked?(user)
    self.currently_locked? && self.user != user
  end
end
