ExamApp::Application.routes.draw do

  resources :teachers
  resources :sessions, :only => [:new, :create, :destroy]
  
  match '/signup',  :to => 'teachers#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  root :to => 'sessions#new'

end
