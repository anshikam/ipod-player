Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'ipod_player#index'

  resources :songs, :controller => 'ipod_player'

  resources :playlists

  post '/playlist/:id/add_song/:song_id', to: 'playlists#add_song'
end
