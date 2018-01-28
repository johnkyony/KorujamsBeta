class AddIssuesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :issues_count, :string
  end
end
