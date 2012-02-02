ExamApp::Application.routes.draw do
  
  resources :teachers
  
  match '/signup', :to => 'teachers#new'
  # root :to => 'welcome#index'

end
