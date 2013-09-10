class RemoveFieldNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :active, :boolean
    remove_column :users, :enabled, :boolean
  end
end
