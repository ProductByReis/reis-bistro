Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Fluxo de reserva. Os três primeiros passos carregam as escolhas pela query
  # string; só o último grava, no POST.
  get "reservas" => "reservations#new", as: :reservas
  post "reservas" => "reservations#create"
  get "reservas/harmonizacao" => "reservations#harmonizacao", as: :reservas_harmonizacao
  get "reservas/dados" => "reservations#dados", as: :reservas_dados

  # O token é longo de propósito: o código curto que o cliente lê na recepção
  # seria adivinhável por tentativa e exporia dados de outras reservas.
  get "reservas/confirmada/:token" => "reservations#confirmada", as: :reservas_confirmada

  # Defines the root path route ("/")
  root "home#index"
end
