Rails.application.routes.draw do

  authenticated :user do
    root to: 'dashboard#show', as: :authenticated_root
  end

  devise_for :users, path: "/", path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout", edit: "edit" }, controllers: { masquerades: "admin/masquerades" }

  root to: 'pages#home'
  get '/dashboard', to: 'dashboard#show'
  get '/account', to: 'account#show'
  get '/godview', to: 'dashboard#godview'
  get '/resources', to: 'pages#resources'
  get '/pricing', to: 'pages#pricing'
  get '/cardsorting', to: 'pages#cardsorting'
  get '/treetesting', to: 'pages#treetesting'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  get '/500', to: 'errors#server_error'
  get '/422', to: 'errors#unacceptable'
  get '/404', to: 'errors#not_found'

  get '/verify', to: 'pages#verify'

  get '/admin/password_reset', to: 'admin#password_reset'

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
  post '/unmerge_groups', to: 'card_sort_groups#unmerge_groups'
  post '/update_merged_group', to: 'card_sort_groups#update_merged_group'

  resources :card_sort_cards
  
  resources :card_sort_participants

  get 'collect_tt/:auth_token', to: 'tree_test_participants#new', as: :tree_test_collect
  get 'collect_tt/:auth_token/:preview', to: 'tree_test_participants#new', as: :tree_test_collect_preview

  get 'collect_cs/:auth_token', to: 'card_sort_participants#new', as: :card_sort_collect
  get 'collect_cs/:auth_token/:preview', to: 'card_sort_participants#new', as: :card_sort_collect_preview  
end
