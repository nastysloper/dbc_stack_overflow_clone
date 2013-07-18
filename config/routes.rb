StackClone::Application.routes.draw do

  root :to => "main#landing"

  resources :events

  resources :comments , :only => [:create, :update, :destroy]

  match 'session/auth', to: 'sessions#auth'

  match '/sign_in', to: 'sessions#sign_in'
  match '/sign_out', to: 'sessions#sign_out'

end
