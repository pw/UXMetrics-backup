Rails.application.routes.draw do
  root to: 'pages#home'
  get '/card-sorts', to: 'pages#card_sorts', as: 'card_sorts_page'
  get '/tree-tests', to: 'pages#tree_tests', as: 'tree_tests_page'
  get '/pricing', to: 'pages#pricing'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  get '/dashboard', to: 'dashboard#show', as: 'dashboard'
  get '/verify', to: 'dashboard#verify', as: 'verify'

  get '/account', to: 'account#show', as: 'account'
  post '/update-email', to: 'account#update_email', as: 'update_email'
  post '/change-password', to: 'account#change_password', as: 'change_password'
  post '/delete_account', to: 'account#delete_account', as: 'delete_account'
  
  get '/godview', to: 'dashboard#godview'

  get '/500', to: 'errors#server_error'
  get '/422', to: 'errors#unacceptable'
  get '/404', to: 'errors#not_found'

  get '/signup', to: 'authentication#new_signup', as: 'signup'
  post '/signup', to: 'authentication#signup', as: 'signup_post'
  get '/login', to: 'authentication#new_login', as: 'login'
  post '/login', to: 'authentication#login', as: 'login_post'
  delete '/logout', to: 'authentication#logout', as: 'logout'
  get '/reset-password', to: 'authentication#new_reset_password', as: 'reset_password'
  post '/reset-password', to: 'authentication#reset_password', as: 'reset_password_post'
  get '/set-password/:token', to: 'authentication#new_set_password', as: 'set_password'
  post '/set-password', to: 'authentication#set_password', as: 'set_password_post'

  get '/email_verification/:token', to: 'email_verification#verify', as: 'email_verification'

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

  get '/admin/password_reset', to: 'admin#password_reset'
end
