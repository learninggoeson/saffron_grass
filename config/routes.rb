Saffrongrass::Application.routes.draw do

  
  resources :role_users

  resources :roles

  resources :contacts

  get 'about' => "about#index"

  get 'admin' => 'admin#index'

  # controller :sessions do
  #   get 'login' => :new
  #   post 'login' => :create
  #   delete 'logout' => :destroy
  # end

  # devise_for :user

  devise_for :users do 
    get '/users/sign_out' => 'devise/sessions#destroy'
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
 
  devise_for :users do
      match 'signup' => 'users#new', :as => :signup
      match 'register' => 'users#create', :as => :register
      match '/login' => 'sessions#new', :as => :login 
      match 'logout' => 'sessions#destroy', :as => :logout
  end

  # devise_for :users
  resources :users
  resources :orders

  resources :line_items

  resources :carts

  # get "store/index"

  resources :products do
    get :who_bought, :on => :member
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'store#index' , :as => 'store'
  root :to => 'store#index'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
