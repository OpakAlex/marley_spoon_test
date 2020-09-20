# frozen_string_literal: true

Rails.application.routes.draw do
  resources :recipes, only: %i[show index]

  root to: 'recipes#index'
end
