class ProjectMilestonesController < ApplicationController
  layout "paper_kit"
   before_action :set_project 
  
  def index
    
    @features = ProjectMilestone.where(project_id: @project.id)
    # paid features all the features that have been paid on this project
    @get_all_paid_features = FeaturePayment.where(project_id: @project.id)
    all_paid_features_milestone_id = @get_all_paid_features.pluck(:project_milestone_id)
    @paid_features = ProjectMilestone.where(id: all_paid_features_milestone_id)
    # this is shall check if the user has paid deposit or not for the current project , if he has  then display the button pay feature 
    @project_feature_count =  @features.count 
    @project_deposit_status = DepositPaid.find_by_project_id(@project.id)
    @is_project_processing = Payment.where(project_id: @project.id , payment_status: "Pending")
    
    
  end

  def new
    project_current_feature_count = ProjectMilestone.where(project_id: @project.id).count 
    
    if project_current_feature_count < 5
        @project_milestone = ProjectMilestone.new
    else
      redirect_to project_project_milestones_path(@project.id)
      flash[:notice] = "Minimal viable version only allow five features"
    end
  
    
    
   
    
  end
  
  def create
    @project_milestone = ProjectMilestone.new(project_milestone_params)
    @project_milestone.project_id = params[:project_id]
    @project_milestone.user_id = current_user.id
    
     # the algorithm for the minimum five feature requirements
    project_current_feature_count = ProjectMilestone.where(project_id: @project.id).count
    if  project_current_feature_count  <  5
      if @project_milestone.save
        project_feature_count_updated = ProjectMilestone.where(project_id: @project.id).count
        if project_feature_count_updated == 5
          redirect_to project_project_milestones_path(@project.id)
          flash[:notice] = "You have completed your #{project_feature_count_updated} features proceed to pay deposit so that we may start building your project"
          
        else
          redirect_to new_project_project_milestone_path(@project.id)
          features_left = 5 - project_feature_count_updated
          flash[:notice] = "This is the #{project_feature_count_updated} feature and you have #{features_left} feature left   to complete"
        end
        
        
      else
        redirect_to  new_project_project_milestone_path(@project.id)
        flash[:success] = "May you please type in that feature again something went wrong"
      end
    else
      redirect_to project_project_milestones_path(@project.id)
      flash[:notice] = "Minimal viable version only allow five features"
        
    end
    
    
  end
  
  def show
    @feature = ProjectMilestone.find_by_id(params[:id])
  end
  
  def edit
    feature_paid_checker = FeaturePayment.find_by_project_milestone_id(params[:id])
    if feature_paid_checker.blank?
      @project_milestone = ProjectMilestone.find(params[:id])
    else
        flash[:success] = "You may not change these details after feature has been paid"
        redirect_to  project_project_milestones_path(@project.id)
    end
    
  end
  
   def update
    @project_milestone = ProjectMilestone.find(params[:id])
    if @project_milestone.update_attributes(project_milestone_params)
      # Handle a successful update.
      redirect_to    project_project_milestone_path(@project_milestone.project_id , @project_milestone.id)
    else
      render 'edit'
      
    end
  end
  private 
  
  def project_milestone_params
    params.require(:project_milestone).permit(:project_id , :title , :description)
    
  end
  
  def set_project
    @project = Project.find(params[:project_id])
  end
 
end
