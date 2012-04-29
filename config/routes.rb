Sketchpad::Application.routes.draw do
  devise_for :users

  match '/:id' => 'pages#show', :as => :static, :via => :get
  root :to => 'pages#show', :id => 'home'
end
