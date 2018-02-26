Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'ipod_player#index'

  resources :songs, :controller => 'ipod_player'

  get '/songs/order/:field', to: 'ipod_player#sort', as: 'ipod_player_sort'
  get '/ipod_player/shuffle_all', to: 'ipod_player#shuffle_all', as: 'ipod_player_shuffle_all'

  resources :playlists

  post '/playlist/:id/add_song/:song_id', to: 'playlists#add_song', as: 'playlist_add_song'
  post '/playlist/:id/delete_song/:song_id', to: 'playlists#delete_song', as: 'playlist_delete_song'
  get '/playlist/:id/order/:field', to: 'playlists#sort', as: 'playlist_sort'
  get '/playlist/:id/shuffle', to: 'playlists#shuffle', as: 'playlist_shuffle'
end
