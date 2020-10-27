Rails.application.routes.draw do
  # Routes for home.
  get 'home/home'
  get 'home/contact'

  # Make home the root of the site.
  root 'home#home'
end
