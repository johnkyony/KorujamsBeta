class AddAvatarToProjectMilestones < ActiveRecord::Migration
  def change
    add_column :project_milestones, :milestone_id, :integer
    add_column :project_milestones, :avatar_url, :string
  end
end
