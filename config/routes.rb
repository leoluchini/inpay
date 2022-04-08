# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :payments, only: %i[index create], defaults: { format: 'json' }
  end
end
