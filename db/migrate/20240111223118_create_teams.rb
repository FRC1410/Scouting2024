class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :number
      t.references :alliance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
