# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: :registrations,
               sessions: :sessions
             }

  get '/*a', to: 'application#not_found'
end
