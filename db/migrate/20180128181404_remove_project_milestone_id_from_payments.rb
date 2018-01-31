class RemoveProjectMilestoneIdFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :project_milestone_id, :string
  end
end
