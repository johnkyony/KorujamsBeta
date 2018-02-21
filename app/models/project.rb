class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_milestone
  has_many :deposit_paid
  has_many :feature_payment
  validates :repo_name , presence: true
  validates :repo_description , presence: true
  validates :user_id , presence: true
  validates :project_solution_to_problem , presence: false
  validates :project_expectation , presence: true
  validates_uniqueness_of :repo_name
end
