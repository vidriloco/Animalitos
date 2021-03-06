# encoding: utf-8
Froyito::Application.routes.draw do
  resources :frente, :only => [:index]
  
  resources :animales do
    put 'edo_caso_cambio', :on => :member    
    resources :fotos, :only => [:index, :create]
  end
  
  resources :fotos, :only => [:index, :destroy, :update]

  devise_for :usuarios, :path_names => { :sign_in => 'iniciar_sesion' } 

  resources :razas, :except => [:show]
   
  resources :usuarios, :only => [:edit, :update, :destroy, :perfil]
  
  match '/perfil' => 'usuarios#perfil', :as => 'usuario_root'
  match '/ayudame/:id' => "animales#show"
  match '/busqueda', :to => 'animales#busqueda', :via => "post"
  match '/busqueda', :to => 'animales#busqueda', :via => "get"
  match '/acerca_de', :to => 'frente#acerca_de', :as => 'acerca_de'
  
  match '/perfil' => 'usuarios#perfil'
  match '/activar/:id', :to => 'usuarios#activar', :as => 'activar', :via => "post"
  match '/desactivar/:id', :to => 'usuarios#desactivar', :as => 'desactivar', :via => "post"
  
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
  root :to => "frente#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
