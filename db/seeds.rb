# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

repos    = Github::Client::Repos.new
response = repos.list user: 'johnkyony', per_page: 10

response.each_page do |page|
  page.each do |repo|
    project = Project.create(repo_id: repo.id , repo_name: repo.name , repo_description: repo.description)


  end
end

# the seed data for the milestones 
all_stored_projects = Project.all 
client = Octokit::Client.new(:login => 'jkyony@gmail.com' , :password => 'f@cus1sbr1ght21')
all_stored_projects.each do |project|
  listing_milestones_of_project = client.list_milestones("johnkyony/#{project.repo_name}")
  if  ! listing_milestones_of_project.nil?
    listing_milestones_of_project.each do |milestone| 
      project_milestone = ProjectMilestone.create(project_id: project.id , title:  milestone.title , description: milestone.description , milestone_id: milestone.id , avatar_url: milestone.creator.avatar_url )
    end
    
    
  end
end

# The github setup 
github = Github.new login:'jkyony@gmail.com', password:'f@cus1sbr1ght21'
# The update method for the projects branches count
projects = Project.all
    projects.each do |project|
      project = Project.find_by_id(project.id)
      project_branches = github.repos.branches.list 'johnkyony' , project.repo_name
      project.update_attribute :branches_count , project_branches.count
      
    end
    
# the update the issues count 

projects.each do |project|
    project = Project.find_by_id(project.id)
    project_issues = github.issues.milestones.list state:'all', user: 'johnkyony' , repo: project.repo_name
    project.update_attribute :issues_count , project_issues.count
end

projects.each do |project|
    project = Project.find_by_id(project.id)
    project_closed_issues = github.issues.milestones.list state:'closed', user: 'johnkyony' , repo: project.repo_name
    project.update_attribute :closed_issues_count , project_closed_issues.count
end

# the seed data for the milestones_states 
all_stored_projects = Project.all 
client = Octokit::Client.new(:login => 'jkyony@gmail.com' , :password => 'f@cus1sbr1ght21')
all_stored_projects.each do |project|
  listing_milestones_of_project = client.list_milestones("johnkyony/#{project.repo_name}" ,:state => "all")
  
  if ! listing_milestones_of_project.nil?
      listing_milestones_of_project.each do |milestone|
          project_milestone = ProjectMilestone.find_by_title(milestone.id)
          project_milestone.update_attribute :state , milestone.state
      end
    
  end
end
