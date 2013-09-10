class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true
    add_reference :users, :state, index: true
  end
end
