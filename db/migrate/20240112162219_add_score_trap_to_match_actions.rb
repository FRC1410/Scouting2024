class AddScoreTrapToMatchActions < ActiveRecord::Migration[7.1]
  def change
    add_column :match_actions, :score_trap, :integer, :default => 0
  end
end
