Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  root "guests#list"

  # Returns 200 when the application boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/guests", to: "guests#create"

  get "/guests", to: "guests#list"
  get "/guests/:id", to: "guests#detail"

  delete "/guests/:id", to: "guests#delete"
end
