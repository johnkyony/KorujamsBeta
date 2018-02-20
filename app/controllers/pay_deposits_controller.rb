class PayDepositsController < ApplicationController
  layout "paper_kit"
  before_action :set_project
  before_action :set_deposit
  before_action :set_feature_paid_for
  before_action :set_github_client
  
  
  def new
   
    deposit_transaction_checker = Payment.find_by_project_id(params[:project_id])
    if  deposit_transaction_checker.blank?
       @deposit_to_be_paid = DepositPaid.new
    # payfast description bang in , make more dynamic 
    @project_deposit_payment = @project.repo_name + "\tDeposit "
    # payfast notify_url 
    # make sure deposit button doesn't repeat again
    payment_processing_time = Payment.create(project_id: @project.id , payment_status: "Pending" , item_name: @project.repo_name , amount_net:  @deposit_amount)
    else
      flash[:notice] = "Your transaction is being processed you shall be noticed when the project status changes"
      redirect_to project_project_milestones_path(@project.id)
    end
      
  end

  def create
    @deposit_to_be_paid = DepositPaid.new
    @deposit_to_be_paid.project_id = @project.id
    @deposit_to_be_paid.amount = @deposit_amount
    @deposit_to_be_paid.paid_status = "true"
    
    # if the deposit is paid and the transaction is saved then for mvp purposes going to create a github repo the upload the repo statistics and open those project milestones as milestones on github
    if @deposit_to_be_paid.save 
      # This moves the first two feature into feature paid table 
      initial_two_deposit_into_feature_paid
      create_github_repo_after_payment(@project.id)
      create_milestones_on_github(@project.id)
      local_to_github_initial_sync(@project.id)
      # for testing purposes 
      flash[:notice] = "This is a successful transaction"
      redirect_to project_project_milestones_path(@project.id)
      
    else
      flash[:sucess] = "This is a failure of a transaction"
      redirect_to project_project_milestones_path(@project.id)
    end
   
  end
  
  
  def show
    
    
  end
  
  private 
  # this should become a  library store in the concern make it faster then 
  def set_project
  @project = Project.find_by_id(params[:project_id])
  end
  
  def set_github_client
     @client = Octokit::Client.new(:login => 'jkyony@gmail.com' , :password => 'f@cus1sbr1ght21')
     # The github setup 
      @github = Github.new login:'jkyony@gmail.com', password:'f@cus1sbr1ght21'
  end
  
  # This feature takes the first two milestones id and displays as features that the deposit covers 
  def set_feature_paid_for 
    @features = ProjectMilestone.where(project_id: @project.id).limit(2)
  end
  # this is to set the calculated deposit amount
  def set_deposit
     @deposit_amount = set_deposit_amount(@project.id)
  end
  # All the methods below should be changed into background jobs 
  
  def initial_two_deposit_into_feature_paid
    @features.each do | feature|
      FeaturePayment.create(project_milestone_id: feature.id , amount: (@deposit_amount / 2) , project_id: @project.id )
    end
  end
  
  def set_deposit_amount(project_id) 
    project_feature_count = ProjectMilestone.where(project_id: project_id).count
    # REMEMBER TO MAKE THIS LINE MORE DYNAMIC
    project_total_amount = project_feature_count * 1000
    project_deposit_amount = project_total_amount * 40/100
    return project_deposit_amount
  end
  
  def create_github_repo_after_payment(project_id)
    project = Project.find_by_id(project_id)
    create_repo = @client.create_repository(project.repo_name ,  {:description => project.repo_description , :has_issues => true })
  end
  
  def create_milestones_on_github(project_id)
    project = Project.find_by_id(project_id)
    project_features = ProjectMilestone.where(project_id: project_id)
    project_features.each do |feature|
      @client.create_milestone("johnkyony/#{project.repo_name}", feature.title, {:description => feature.description})
    end
  end
  
  def local_to_github_initial_sync(project_id)
     project = Project.find_by_id(project_id)
      project_branches = @github.repos.branches.list 'johnkyony' , project.repo_name
      project.update_attribute :branches_count , project_branches.count
       project_issues = @github.issues.milestones.list state:'all', user: 'johnkyony' , repo: project.repo_name
        project.update_attribute :issues_count , project_issues.count
      project_closed_issues = @github.issues.milestones.list state:'closed', user: 'johnkyony' , repo: project.repo_name
    project.update_attribute :closed_issues_count , project_closed_issues.count
  end
end
