class AddAutoMationAction < ActiveRecord::Migration[7.1]
  def change
    add_column :match_actions, :score_speaker_auto, :integer, :default => 0
    add_column :match_actions, :score_amp_auto, :integer, :default => 0
  end
end
