Rails.application.routes.draw do
  # get 'pay_features/new'

  # get 'pay_features/create'

  # get 'pay_deposits/new'

  # get 'pay_deposits/create'

  # get 'project_milestones/index'

  # get 'project_milestones/new'

  # get 'projects/index'

  # get 'projects/new'

  devise_for :users
  resources :users
  # non nested routes 
  resources :projects
  resources :project_milestones
  resources :pay_features
  resources :pay_deposits
  
  # routes for paying deposit for project 
  resources :project do 
    resources :pay_deposits
  end
  
  # routes for paying features 
  resources :project_milestones do 
    resources :pay_features
  end
  # routes for projects and their milestones 
    resources :projects do 
      resources :project_milestones
    end
  root to: 'projects#index'
end
