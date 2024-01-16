class MatchBelongsToCompetion < ActiveRecord::Migration[7.1]
  def change
    change_table :matches do |table|
      table.references :competition, null: false, foreign_key: true, default: 1
    end
  end
end
