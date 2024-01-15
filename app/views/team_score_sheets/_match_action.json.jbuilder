json.extract! team_score_sheet, :id, :match_id, :team_id, :action_id, :score, :created_at, :updated_at
json.url team_score_sheet_url(team_score_sheet, format: :json)
