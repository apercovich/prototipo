class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role
      t.boolean :active
      t.boolean :enabled

      t.timestamps
    end
  end
end
