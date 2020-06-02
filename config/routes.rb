Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/users/worktime/new', to: 'worktimes#new', as: 'intime'
  post '/users/worktime/update', to: 'worktimes#update', as: 'outtime'
  get  '/users/:id', to: "users#entry", as: 'entry'
  post '/users/:id/history', to: 'worktimes#list', as: 'list'
  get '/users/:id/history', to: 'worktimes#history', as: 'history'
  resources :users, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
