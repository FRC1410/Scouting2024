class CreateMatchActions < ActiveRecord::Migration[7.1]
  def change
    create_table :match_actions do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :score_speaker
      t.integer :score_amp
      t.boolean :leave

      t.timestamps
    end
  end
end
