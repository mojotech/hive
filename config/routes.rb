Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :sign_out

  resources :users, param: :nickname, only: 'show'
  resources :organizations, param: :login, only: 'show'

  resources :apps do
    member do
      get :lanes
    end
    resources :tickets, only: [:create, :show, :destroy, :update] do
      member do
        post :claim
        post :remove_owner
        post :update_lane
        post :update_points
      end
    end
    resources :lanes, only: [:create]
    resources :documents, only: [:show]
    resources :features, only: [:create, :show]
  end

  resources :tickets, only: [] do
    resources :acceptance_criteria, only: [:create]
  end

  get '/:owner/:repo_name' => 'repositories#show', as: 'repository'
  post '/:owner/:repo_name/create_branch' => 'repositories#create_branch', as: 'repository_create_branch'
  get '/:owner/:repo_name/new_branch' => 'repositories#new_branch', as: 'repository_new_branch'

  get '/:owner/:repo_name/:branch_name' => 'branches#show', as: 'branch'
  patch '/:owner/:repo_name/:branch_name' => 'branches#update'

end
