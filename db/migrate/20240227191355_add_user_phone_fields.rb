class AddUserPhoneFields < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |table|
      table.text :user_phone
      table.boolean :user_phone_opt_in
    end
  end
end
