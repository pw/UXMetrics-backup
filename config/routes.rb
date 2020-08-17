Rails.application.routes.draw do

  get 'users/index'
  resource :billing, controller: 'sjabloon/billing', only: [:create, :update, :destroy] do
    member do
      get 'setup', to: 'sjabloon/billing#new', as: 'new'
      get '/', to: 'sjabloon/billing#show'
    end

    resources :plans, controller: 'sjabloon/plans', only: [:index, :update]
  end
  resource  :card,    controller: 'sjabloon/card',    only: [:update]
  resources :coupons, controller: 'sjabloon/coupons', only: [:index]
  resources :charges, controller: 'sjabloon/charges', only: [:show]
  # resource  :pricing, controller: 'sjabloon/pricing', only: [:show]



  post '/webhooks/stripe', to: 'stripe_event/webhook#event'

  authenticated :user do
    root to: 'dashboard#show'
    # resource  :pricing, controller: 'sjabloon/pricing', only: [:show]
    resource :pricing, controller: 'sjabloon/pricing', only: [:show, :expired] do
      member do
        get :expired
      end
    end
    # get '/pricing', to: 'pages#pricing'
  end
  devise_for :users, path: "/", path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout", edit: "edit" }, controllers: { masquerades: "admin/masquerades" }
  get '/dashboard', to: 'dashboard#show'
  get '/resources', to: 'pages#resources'
  get '/pricing', to: 'pages#pricing'
  get '/features', to: 'pages#features'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'
  root to: 'pages#home'
  get '/500', to: 'errors#server_error'
  get '/422', to: 'errors#unacceptable'
  get '/404', to: 'errors#not_found'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cards

  resources :cardtests, param: :uid do
    resources :results, param: :id do
      collection do
        get :download
      end
    end
    member do
      patch :update_merged
    end
    member do
      delete :delete_image_attachment
    end

  end

  resources :tree_tests do
    get 'report', on: :member
    get 'participants', on: :member
  end

  resources :tree_test_tasks do
    get 'outcome', on: :member
  end

  resources :tree_test_participants
  
  resources :card_sorts do 
    get 'report', on: :member
  end
  
  resources :card_sort_groups
  post '/participant_designated_card_sort_groups', to: 'card_sort_groups#create_participant_designated_group'
  post '/merge_groups', to: 'card_sort_groups#merge_groups'
  resources :card_sort_cards
  resources :card_sort_participants

  get 'collect/:auth_token/thanks', to: 'results#thanks', as: :thanks
  post 'cardtests/:auth_token/results', to: 'results#create'
  post 'collect/:auth_token/results', to: 'results#create'

  get "/cardsorts/*page" => "cardsorts#show"
  get "/cardsorts", to: "cardsorts#index"
  get "/cardsort_participants/*page" => "cardsort_participants#show"
  get "/cardsort_participants", to: "cardsort_participants#index"

  get 'collect/:auth_token', to: 'results#new'

  get 'collect_tt/:auth_token', to: 'tree_test_participants#new', as: :tree_test_collect
  get 'collect_tt/:auth_token/:preview', to: 'tree_test_participants#new', as: :tree_test_collect_preview

  get 'collect_cs/:auth_token', to: 'card_sort_participants#new', as: :card_sort_collect
  get 'collect_cs/:auth_token/:preview', to: 'card_sort_participants#new', as: :card_sort_collect_preview  

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
