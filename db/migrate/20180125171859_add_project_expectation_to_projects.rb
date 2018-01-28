class AddProjectExpectationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_solution_to_problem, :string
    add_column :projects, :project_expectation, :string
  end
end
