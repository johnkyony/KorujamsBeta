class ProjectMilestonesController < ApplicationController
   before_action :set_project 
  
  def index
    @project_milestones = ProjectMilestone.where(@project.id)
  end

  def new
  end
  private 
  def set_project
    @project = Project.find(params[:project_id])
  end
  
end
