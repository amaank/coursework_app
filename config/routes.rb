Rails.application.routes.draw do
  # Routes for home.
  get 'contact', to: 'home#contact'

  # Make home the root of the site.
  root 'home#home'
end
