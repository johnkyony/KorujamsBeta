class AddUserToProjectMilestones < ActiveRecord::Migration
  def change
    add_reference :project_milestones, :user, index: true, foreign_key: true
  end
end
