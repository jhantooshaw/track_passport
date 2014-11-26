Rails.application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #authenticated :user do
  #  root :to => 'passports#index', :as => :valid_user
  resources :passports do
    collection do
      get 'search'
    end
    member do
      get 'visas'
      post 'change-status/:visa_id' => 'passports#visa_status', as: :change_status
      delete 'destroy_visa/:visa_id' => 'passports#destroy_visa', as: :delete_visa
      get 'add-visa'    => 'passports#add_visa'
      post 'add-visa'    => 'passports#add_visa'
    end
  end
  #end
  
  # You can have the root of your site routed with "root"
  root 'visas#home'
  
  match 'check-valid-email' => 'application#valid_email',   :via => :get,  :as => :valid_email
   
  match 'track-visa' => 'visas#track', :via => [:get, :post], :as => :track_visa
  
  match 'tourist-visa'=> 'visas#tourist', :via => :get, :as => :tourist_visa
  match 'transit-visa'=> 'visas#transit', :via => :get, :as => :transit_visa
  match 'contact'     => 'visas#contact', :via => :get, :as => :contact
  match 'online-form' => 'visas#online_form', :via => :get, :as => :online_form
  match 'download-form' => 'visas#download_form', :via => :get, :as => :download_form
  

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
