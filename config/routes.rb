WhiteboardApp::Application.routes.draw do
  resources :whiteboards

  devise_for :users

  match '/:id' => 'pages#show', :as => :static, :via => :get
  root :to => 'whiteboards#index'
end
