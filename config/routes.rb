Votr::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create', via: [:post, :get]
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :proposals, only: [:index, :show] do
    collection do
      get "votes"
      get "all"
    end

    resources :votes, only: [:create]
  end

  namespace :admin do
    get "", to: redirect("/admin/proposals")
    resources :proposals
  end

  root to: redirect("/proposals")

end
