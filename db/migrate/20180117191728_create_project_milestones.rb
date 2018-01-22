class CreateProjectMilestones < ActiveRecord::Migration
  def change
    create_table :project_milestones do |t|
      t.references :project, index: true, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
