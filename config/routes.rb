Rails.application.routes.draw do
  
  #Sessions
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'

  #Courses
  resources :courses do
    resources :archives, only: [:create, :update, :destroy] 
    get 'download_file/:id', to: 'archives#download', as: 'download_file'
  end
  patch 'courses/:id/matriculate_students', to: 'courses#matriculate_students', as: 'matriculate_students'
  patch 'courses/:id/add_calification/:user_id', to: 'courses#add_calification', as: 'add_calification'

  #Articles
  resources :articles do
    resources :comments, only: [:create, :update, :destroy]
  end

  #Users
  #index show in the home admin only
  #new show in welcome
  #destroy no available
  resources :users, :except => [:new, :edit, :destroy] 
  patch 'activate_account/:id', controller: 'users', to: 'users#activate_account', as: 'activate_account'
  
  #Welcome page for sign-up and sign-in
  get 'welcome', to: 'welcome#show'

  #Root page home, only access posible through a session active
  root "home#show"

end
