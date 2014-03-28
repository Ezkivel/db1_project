Project::Application.routes.draw do
  
  devise_for :users
  resources :main
  resources :tickets_online
  resources :tickets
  resources :employee_options
  resources :create_employees
  resources :packages
  resources :report_customers
  resources :report_customer_tickets
  resources :report_customer_packages
  resources :report_employees
  resources :report_employee_tickets
  resources :report_employee_packages
  resources :report_tickets_month
  resources :report_tickets_day
  resources :report_packages_month
  resources :report_packages_day
  resources :about
  resources :contact
  
  get "main/index"
  
  get "about/index"
  
  get "contact/index"
  
  get "tickets_online/index"
  get "tickets_online/show"
  
  get "employee_options/index"
  
  get "tickets/index"
  get "tickets/show"
  
  get "create_employees/index"
  get "create_employees/show"
  
  get "packages/index"
  get "packages/show"
  
  get "report_customers/index"
  
  get "report_customer_tickets/index"
  get "report_customer_tickets/show"
  
  get "report_customer_packages/index"
  get "report_customer_packages/show"
  
  get "report_employees/index"
  
  get "report_employee_tickets/index"
  get "report_employee_tickets/show"
  
  get "report_employee_packages/index"
  get "report_employee_packages/show"
  
  get "report_tickets_month/index"
  get "report_tickets_month/show"
  
  get "report_tickets_day/index"
  get "report_tickets_day/show"
  
  get "report_packages_month/index"
  get "report_packages_month/show"
  
  get "report_packages_day/index"
  get "report_packages_day/show"
  
  root 'main#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
