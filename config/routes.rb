StackClone::Application.routes.draw do

  root :to => "main#landing"

  resources :events

  resources :comments , :only => {:create, :edit, :destroy}

end
