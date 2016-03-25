class RenameColumnTypeInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :type, :tasktype
  end
end
