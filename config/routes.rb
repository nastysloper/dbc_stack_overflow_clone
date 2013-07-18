StackClone::Application.routes.draw do

  root :to => "main#landing"

  resources :events

  resources :comments , :only => [:create, :edit, :destroy]

  match 'user/auth', to: 'users#auth'

  match '/sign_in', to: 'users#sign_in'
  match '/sign_out', to: 'users#sign_out'

end
