Rails.application.routes.draw do



  devise_for :users
  resources :users
  # non nested routes 
  resources :projects
  resources :project_milestones
  resources :pay_features
  resources :pay_deposits
  resources :account_details
  resources :conversations , only: [:index , :show]
  resources :personal_messages , only: [:create]
  resources :developers
  resources :landing_pages
  resources :admins
  # routes for project account details 
  resources :projects do 
   resources :account_details
  end 
  # routes for paying deposit for project 
  resources :project do 
    resources :pay_deposits
  end
  
  # routes for paying features 
  resources :project do 
    resources :pay_features
  end
  # routes for projects and their milestones 
    resources :projects do 
      resources :project_milestones
    end
  root to: 'projects#index'
end
