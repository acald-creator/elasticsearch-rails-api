Rails.application.routes.draw do
  # root 'hello_angular#index'
  get 'hello_angular/index'
  get 'hello_angular/name'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  # Namespace API Post
  namespace :api do
    resources :posts

    get 'people/auto_complete'
  end

  resources :users
  resources :articles



end
