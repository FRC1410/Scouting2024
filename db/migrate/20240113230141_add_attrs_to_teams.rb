class AddAttrsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :team_type, :text
    add_column :teams, :location, :text
    add_column :teams, :logo, :text
  end
end
