class RemoveFieldNameFromLogs < ActiveRecord::Migration
  def change
    remove_reference :logs, :record, index: true
  end
end
