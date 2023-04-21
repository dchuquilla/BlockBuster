# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }, skip: [:passwords], defaults: {format: :json}
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[update index show]
      resources :rents, only: %i[create show]
      resources :tickets, only: %i[update show] do
        collection do
          get 'validate/:code', to: 'tickets#show', as: 'validate'
          patch 'return/:code', to: 'tickets#return', as: 'return'
        end
      end
    end
  end
end
