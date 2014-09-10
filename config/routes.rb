Votr::Application.routes.draw do

  constraints(:host => /(www.)?fel-one-day-votr.herokuapp.com/) do
    match "/(*path)" => redirect {|params, req| "http://epic.frontendlondon.co.uk/#{params[:path]}"},  via: [:get, :post]
  end

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
    resources :proposals do
      post "close"
      post "open"
    end
  end

  root to: "pages#index"

end
