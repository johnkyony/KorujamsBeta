class AddStateToProjectMilestones < ActiveRecord::Migration
  def change
    add_column :project_milestones, :state, :string
  end
end
