class ProjectMilestone < ActiveRecord::Base
  # the search query for milestones for projects
  include OrderQuery
  order_query :order_features , [:project_id , :desc] , [:id , :desc]
  
  belongs_to :project
  has_many :feature_payment
   after_initialize :set_default_state, :if => :new_record?
  validates :project_id , presence: true
  validates :title , presence: true
  validates :description , presence: true
  validates :user_id , presence: true

  def set_default_state
    self.state = "Open"
  end
end
