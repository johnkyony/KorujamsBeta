class ProjectsController < ApplicationController
  layout "paper_kit"
  before_action :set_github
  before_action :authenticate_user!
  

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
      flash[:notice] = "Your Project has been created \t" + @project.repo_name
      redirect_to new_project_project_milestone_path(@project.id)
    else
      flash[:success] = "Something went wrong , please try to answer all the questions. Even if its a rough idea or answer"
      redirect_to new_project_path
    end
    
    

  end
  
  def edit
    deposit_paid_checker = DepositPaid.find_by_project_id(params[:id])
    if deposit_paid_checker.blank?
      @project = Project.find(params[:id])
    else
        flash[:success] = "You may not change these details after deposit been paid"
        redirect_to  project_project_milestones_path(deposit_paid_checker.project_id)
    end
    
  end
  
  def update
     @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      # Handle a successful update.
      flash[:notice] = "Changes have been saved"
      redirect_to  project_project_milestones_path(@project.id)
    else
      flash[:success] = "Something went wrong please try again "
      render 'edit'
      
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
