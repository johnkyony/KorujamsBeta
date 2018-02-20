class PayFeaturesController < ApplicationController
  layout "paper_kit"
  before_action :set_project
  before_action :set_feature_paying_for
  before_action :set_feature_price
  
  
  def new
    @feature
  end

  def create
   @successful_paid_feature = FeaturePayment.create(project_milestone_id: @feature.id , amount: @feature_per_price , project_id: @project.id )
   redirect_to project_project_milestones_path(@project.id)
  end
  private 
  def set_project
    @project = Project.find(params[:project_id])
  end
  
  def set_feature_paying_for
   last_feature_paid_for = FeaturePayment.where(project_id: params[:project_id]).pluck(:project_milestone_id).last
   last_feature = ProjectMilestone.order_features_at(ProjectMilestone.find(last_feature_paid_for))
   @feature = last_feature.next
    
  end
  
  def set_feature_price
    @feature_per_price = 1000
    
  end
end
