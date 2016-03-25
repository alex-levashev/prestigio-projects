class AddStarttimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :starttime, :datetime
  end
end
