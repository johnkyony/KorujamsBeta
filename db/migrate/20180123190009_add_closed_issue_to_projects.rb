class AddClosedIssueToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :closed_issues_count, :string
  end
end
