ExamApp::Application.routes.draw do
  
  get "teachers/new"

  resources :teachers
  
  # match '/signup', :to => 'teachers#new'
  # root :to => 'welcome#index'

end
