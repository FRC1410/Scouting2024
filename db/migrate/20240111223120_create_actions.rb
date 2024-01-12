class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions do |t|
      t.string :name
      t.integer :points

      t.timestamps
    end
  end
end
