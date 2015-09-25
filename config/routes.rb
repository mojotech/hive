Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :sign_out

  resources :users, param: :nickname, only: 'show'
  resources :organizations, param: :login, only: 'show'

  resources :apps
  get '/:owner/:repo_name' => 'repositories#show', as: 'repository'
  post '/:owner/:repo_name/create_branch' => 'repositories#create_branch', as: 'repository_create_branch'
  get '/:owner/:repo_name/new_branch' => 'repositories#new_branch', as: 'repository_new_branch'

  get '/:owner/:repo_name/:branch_name' => 'branches#show', as: 'branch'
  patch '/:owner/:repo_name/:branch_name' => 'branches#update'

end
