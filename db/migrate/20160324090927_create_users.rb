  class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :role
      t.boolean :admin
      t.boolean :activated

      t.timestamps null: false
    end
  end
end
