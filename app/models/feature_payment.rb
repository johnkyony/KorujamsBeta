class FeaturePayment < ActiveRecord::Base
  belongs_to :project_milestone
  validates :project_milestone_id, uniqueness: true
end
