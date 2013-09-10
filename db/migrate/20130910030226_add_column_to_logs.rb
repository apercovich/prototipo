class AddColumnToLogs < ActiveRecord::Migration
  def change
    add_reference :logs, :task, index: true
  end
end
