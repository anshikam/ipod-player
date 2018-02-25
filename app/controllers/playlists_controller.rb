class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def new

  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def create
    @playlist = Playlist.new(params.require(:playlist).permit(:name))
    @playlist.save

    redirect_to playlists_path
  end

  def delete
    Playlist.destroy(params.require(:playlist).permit(:id))
    redirect_to playlists_path
  end

  def update
    playlist_params = params.require(:playlist).permit(:id, :name)
    @playlist = Playlist.find(playlist_params[:id])
    @playlist.update(name: playlist_params[:name])

    redirect_to @playlist
  end

  def add_song
    playlist_params = params.require(:playlist).permit(:song_id, :playlist_id)
    @playlist_song = PlaylistSong.new(song_id: playlist_params[:song_id], playlist_id: playlist_params[:playlist_id])
    @playlist_song.save

    redirect_to @playlist
  end

  def delete_song
    playlist_params = params.require(:playlist).permit(:song_id, :playlist_id)
    @playlist_song = PlaylistSong.find(song_id: playlist_params[:song_id], playlist_id: playlist_params[:playlist_id])
    @playlist_song.delete

    redirect_to @playlist
  end
end
