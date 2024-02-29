class CreatePrizes < ActiveRecord::Migration[7.1]
  def change
    create_table :prizes do |t|
      t.boolean :locked, default: false

      t.timestamps
    end

    create_table :prizes_users do |t|
      t.references :prize, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
