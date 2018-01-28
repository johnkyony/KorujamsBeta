class ProjectMilestonesController < ApplicationController
   before_action :set_project 
  
  def index
    @project_milestones = ProjectMilestone.where(project_id: @project.id)
    if @project_milestones.blank?
      @project 
    end
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
  private 
  
  def project_milestone_params
    params.require(:project_milestone).permit(:project_id , :title , :description)
    
  end
  
  def set_project
    @project = Project.find(params[:project_id])
  end
  
end
