class AddCompletedToMatches < ActiveRecord::Migration[7.1]
  def change
    change_table :matches do |table|
      table.boolean :completed, default: false
    end
  end
end
