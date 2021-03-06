Rails.application.routes.draw do
 
  get 'welcome/index'
  
  #Routes for knowledge node viewing, creation, and deletion
  get 'nodes' => 'nodes#index'
  get 'node' => 'nodes#index'
  post 'nodes' => 'nodes#create'
  get 'nodes/new/' => 'nodes#new' #This has to go before nodes/:id
  get 'nodes/:id/edit' => 'nodes#edit'
  post 'nodes/:id/edit' => 'nodes#update'
  get 'nodes/:id' => 'nodes#show'
  get 'node/:id' => 'nodes#show'
  post 'nodes/:id' => 'nodes#create_relationship'
  delete 'nodes/:id' => 'nodes#destroy'
  get 'nodes/get_nodes/:search' => 'nodes#search'
  
  #Routes for chat messages
  get 'chat' => 'chat#index'
  post 'chat' => 'chat#create'

  root 'welcome#index'

  #Routes for user signup and authentication
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  #Routes for admin panel
  get 'admin' => 'admin#home'
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
