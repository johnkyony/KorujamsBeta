Rails.application.routes.draw do

  get 'payments/paid'

  get 'payments/success'

  get 'payments/fail'

  get 'project_milestones/index'



devise_scope :user do
  get "sign_out", :to => "devise/sessions#destroy"
end
  devise_for :users
  resources :users
  # non nested routes 
  resources :projects
  resources :project_milestones
  resources :pay_features
  resources :pay_deposits
  resources :account_details
  resources :conversations , only: [:index , :show]
  resources :personal_messages 
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
  
  # routes for paying deposit with payfast integration 
  resources :project do 
     scope 'pay_fast' do 
        post 'paid' => 'payments#paid' , as: :payfast_paid
        get 'success' => 'payments#success' , as: :payfast_success
        get 'fail' => 'payments#fail' , as: :payfast_fail
      end
  end
  # routes for paying features 
  resources :project do 
    resources :pay_features
  end
  # routes for projects and their milestones 
    resources :projects do 
      resources :project_milestones
    end
  # routes for feature payments and project_milestones 
  # scope 'pay_fast' do 
  #   post 'paid' => 'payments#paid' , as: :payfast_paid
  #   get 'success' => 'payments#success' , as: :payfast_success
  #   get 'fail' => 'payments#fail' , as: :payfast_fail
  # end
  # resources :projects do 
  #   resources :payments
  # end
  root to: 'landing_pages#index'
end
