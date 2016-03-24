class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true
      t.string :type
      t.string :label
      t.string :text

      t.timestamps null: false
    end
  end
end
