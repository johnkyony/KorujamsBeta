class AccountDetailsController < ApplicationController
  before_action :set_project
  def index
   @feature_payment_history = FeaturePayment.where(project_id: @project.id)
  end
  private 
  def set_project
   @project = Project.find_by_id(params[:project_id])
  end
  
  # remember to make this more dynamic
  
end
