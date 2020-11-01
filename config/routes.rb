Rails.application.routes.draw do
  # Routes for home.
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # Routes for spaces.
  get 'spaces', to: 'spaces#index'
  get 'spaces/:id', to: 'spaces#show' # may not need - remove if unused

  # Routes for cost_types.
  # Consider nicer URLs instead of e.g. '/cost_types'
  get 'cost_types', to: 'cost_types#index'

  # Make home the root of the site.
  root 'home#home'
end
