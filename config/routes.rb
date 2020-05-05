ChoreTracker::Application.routes.draw do
  # Generated routes for models
  resources :chores
  resources :tasks
  resources :children
  
  # Setting default route
  root to: 'chores#index'
  

end
