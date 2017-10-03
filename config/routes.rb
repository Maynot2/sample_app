Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/help'
  get 'static_pages/about' # creates a route to the about page via the StaticPages controller
  get 'static_pages/contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
