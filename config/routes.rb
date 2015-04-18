Rails.application.routes.draw do
  resources :responders,  only: [:index, :create, :show, :update], defaults: { format: :json }, param: :name
  resources :emergencies,  only: [:index, :create, :show, :update], defaults: { format: :json }, param: :code

  match '*path', to: 'application#render_not_found', via: [:get, :patch, :delete]
end
