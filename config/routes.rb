Rails.application.routes.draw do
  get 'project_milestones/index'

  get 'project_milestones/new'

  get 'projects/index'

  get 'projects/new'

  devise_for :users
  resources :users
  # non nested routes 
  resources :projects
  resources :project_milestones
  # routes for projects and their milestones 
    resources :projects do 
      resources :project_milestones
    end
  root to: 'projects#index'
end
