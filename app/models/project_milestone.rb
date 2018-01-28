class ProjectMilestone < ActiveRecord::Base
  belongs_to :project
   after_initialize :set_default_state, :if => :new_record?
  validates :project_id , presence: true
  validates :title , presence: true
  validates :description , presence: true
  validates :user_id , presence: true

  def set_default_state
    self.state = "Open"
  end
end
