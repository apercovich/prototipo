class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.datetime :date
      t.string :type
      t.integer :minutes
      t.references :previous, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
