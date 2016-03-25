class AddAssigneeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assignee, :string
  end
end
