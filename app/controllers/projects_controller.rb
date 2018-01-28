class ProjectsController < ApplicationController
  before_action :set_github
  

  before_action :authenticate_user!
  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def new
    @project = Project.new
  end
  
  def create 
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to new_project_project_milestone_path(@project.id)
    else
      render 'new'
    end
    
    

  end
  
  private 

  def project_params
    params.require(:project).permit(:repo_name , :repo_description , :project_solution_to_problem , :project_expectation)
    
  end
  def set_github
    @github = Github.new login:'jkyony@gmail.com', password:'f@cus1sbr1ght21'
    
  end
end
