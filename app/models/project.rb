class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_milestone
  validates :repo_name , presence: true
  validates :repo_description , presence: true
  validates :user_id , presence: true
  validates :project_solution_to_problem , presence: true
  validates :project_expectation , presence: true
  validates_uniqueness_of :repo_name
end
