class CreateRedmine < ActiveRecord::Migration
  def change
    create_table :redminers do |t|
      t.string :redmine_id
      t.string :redmine_project_name
      t.string :redmine_parent_id
    end
  end
end
