Rails.application.routes.draw do
  # Routes for home.
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # Routes for spaces.
  get 'spaces', to: 'spaces#index'

  # Routes for cost_types.
  get 'cost_types', to: 'cost_types#index'

  # Routes for vehicles.
  resources :vehicles do
    # Routes for bookings.
    resources :bookings
  end

  # Make home the root of the site.
  root 'home#home'
end
