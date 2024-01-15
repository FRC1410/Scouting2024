class AddDetailsToMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :alliance_teams do |t|
      t.references :team, null: false, foreign_key: true
      t.references :alliance, null: false, foreign_key: true

      t.timestamps
    end

    add_column :matches, :match_number, :integer
    remove_column :alliances, :competitions_id, :integer
    remove_column :alliances, :competition_id, :integer

    change_table :alliances do |table|
      table.integer :color, null: false
    end

    change_table :matches do |table|
      table.references :red_alliance, foreign_key: {to_table: :alliances}
      table.references :blue_alliance, foreign_key: {to_table: :alliances}
    end
  end
end
