ExamApp::Application.routes.draw do
  
  get "sessions/new"

  resources :teachers
  
  match '/signup', :to => 'teachers#new'
  # root :to => 'welcome#index'

end
