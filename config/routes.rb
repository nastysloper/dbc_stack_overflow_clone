StackClone::Application.routes.draw do

  resources :events

  resources :comments , :only => {:create, :edit, :destroy}

end
