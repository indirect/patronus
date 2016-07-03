Rails.application.routes.draw do
  post "/github/webhook" => "github_web_hook#create"

  github_authenticate do
    get '/profile' => 'users#show', as: :profile
    resource :reviewerships, only: [:create]
    get '/r/:account_name/:repo_name' => 'repos#show', as: :repo
  end

  get '/login'  => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  root to: 'sessions#create'
end
