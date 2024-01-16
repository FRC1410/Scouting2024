class RemoveMatchActionAndAction < ActiveRecord::Migration[7.1]
  def change
    drop_table :match_actions
    drop_table :actions
  end
end
