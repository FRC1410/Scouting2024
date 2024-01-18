class TeamLog < ApplicationRecord
  after_create_commit -> {
    broadcast_append_to "team_logs",
                         partial: "teams/team_log",
                         locals: {
                           team_log: self,
                           team: self.team,
                           markdown: Redcarpet::Markdown.new(Redcarpet::Render::HTML),
                         },
                         target: "team_logs"
  }

  belongs_to :team
  belongs_to :alliance, required: false
end
