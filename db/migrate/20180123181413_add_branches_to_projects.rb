class AddBranchesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :branches_count, :string
  end
end
