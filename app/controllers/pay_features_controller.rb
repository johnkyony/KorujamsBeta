class PayFeaturesController < ApplicationController
  
  before_action :set_project
  def new
   last_feature_paid_for = FeaturePayment.where(project_id: params[:project_id]).pluck(:project_milestone_id).last
   last_feature = ProjectMilestone.order_features_at(ProjectMilestone.find(last_feature_paid_for))
   @feature = last_feature.next
  end

  def create
  end
  private 
  def set_project
    @project = Project.find(params[:project_id])
  end
end
