Rails.application.routes.draw do
 
  get 'home/index'
  resources :pollies

  resources :vsers

  resources :maps
  resources :places

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Blazer::Engine, at: "blazer"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


# post '/quote', to: 'quotes#create'
post '/lead', to: 'leads#create'
post '/intervention', to: 'intervention#create'



  
  root 'pages#index'





  get '/commercial', to: 'pages#commercial'


  get '/residential', to: 'pages#residential'
  resources :leads
  resources :quotes
  get '/index', to: 'pages#index'

  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

get '/map', to: 'admin#map'

resources :maps


get '/intervention', to: 'pages#intervention'
get 'get_building_by_customer/:customer_id', to: 'intervention#get_building_by_customer'
get 'get_battery_by_building/:building_id', to: 'intervention#get_battery_by_building'
get 'get_column_by_battery/:battery_id', to: 'intervention#get_column_by_battery'
get 'get_elevator_by_column/:column_id', to: 'intervention#get_elevator_by_column'

end

