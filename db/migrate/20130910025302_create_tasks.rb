class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :date
      t.time :time_start
      t.time :time_end
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
