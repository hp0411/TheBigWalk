Rails.application.routes.draw do
  get 'checkpoints/index' #
  get 'checkpoints/new'  #
  get 'checkpoints/create'
  get 'checkpoints/destroy'
  get 'checkpoints/show' #
  get 'checkpoints/:id/edit', to: 'checkpoints#edit', as: 'edit_checkpoint' #
  patch 'checkpoints/:id', to: 'checkpoints#update'
  resources :checkpoints, only: [:index, :new, :create, :destroy, :show , :edit]
  root "application#index"

  # post '/test_sheet', to: 'test_sheet#create'
  post '/checkin', to: 'checkin#create'
  post '/dropout', to: 'checkin#dropout'
  post 'contact', to: 'static_pages#test_number', as: 'test_number'

  resources :checkin
  resources :admin
  resources :help
end

