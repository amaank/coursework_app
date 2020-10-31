Rails.application.routes.draw do
  # Routes for home.
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # Make home the root of the site.
  root 'home#home'
end
