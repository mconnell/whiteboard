Sketchpad::Application.routes.draw do
  resources :drawings

  devise_for :users

  match '/:id' => 'pages#show', :as => :static, :via => :get
  root :to => 'drawings#index'
end
