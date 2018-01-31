Rails.application.routes.draw do
  get 'payments/paid'

  get 'payments/success'

  get 'payments/fail'

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
  # routes for feature payments and project_milestones 
  scope 'pay_fast' do 
    post 'paid' => 'payments#paid' , as: :payfast_paid
    get 'success' => 'payments#success' , as: :payfast_success
    get 'fail' => 'payments#fail' , as: :payfast_fail
  end
  resources :projects do 
    resources :payments
  end
  root to: 'projects#index'
end
