class AccountDetailsController < ApplicationController
 layout "paper_kit"
  before_action :set_project
  before_action :authenticate_user!
  def index
   @feature_payment_history = FeaturePayment.where(project_id: @project.id)
  end
  private 
  def set_project
   @project = Project.find_by_id(params[:project_id])
  end
  
  # remember to make this more dynamic
  
end
