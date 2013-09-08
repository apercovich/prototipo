class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :date
      t.string :action
      t.text :description
      t.references :record, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
