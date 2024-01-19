class RemoveOldAllianceRelations < ActiveRecord::Migration[7.1]
  def change
    change_table :matches do |table|
      table.remove_references :blue_alliance, foreign_key: {to_table: :alliances}
      table.remove_references :red_alliance, foreign_key: {to_table: :alliances}
    end
  end
end
