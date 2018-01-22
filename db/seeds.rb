# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# repos    = Github::Client::Repos.new
# response = repos.list user: 'johnkyony', per_page: 10

# response.each_page do |page|
#   page.each do |repo|
#     project = Project.create(repo_id: repo.id , repo_name: repo.name , repo_description: repo.description)


#   end
# end

# the seed data for the milestones 
# all_stored_projects = Project.all 
# client = Octokit::Client.new(:login => 'jkyony@gmail.com' , :password => 'f@cus1sbr1ght21')
# all_stored_projects.each do |project|
#   listing_milestones_of_project = client.list_milestones("johnkyony/#{project.repo_name}")
#   if  ! listing_milestones_of_project.nil?
#     listing_milestones_of_project.each do |milestone| 
#       project_milestone = ProjectMilestone.create(project_id: project.id , title:  milestone.title , description: milestone.description , milestone_id: milestone.id , avatar_url: milestone.creator.avatar_url )
#     end
    
    
#   end
# end
