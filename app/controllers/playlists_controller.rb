class PlaylistsController < ApplicationController
  skip_before_action :verify_authenticity_token
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
    playlist_params = params.permit(:song_id, :id)
    @playlist_song = PlaylistSong.new(song_id: playlist_params[:song_id], playlist_id: playlist_params[:id])
    @playlist_song.save

    redirect_to @playlist_song.playlist
  end

  def delete_song
    playlist_params = params.permit(:song_id, :id)
    @playlist_song = PlaylistSong.find_by(song_id: playlist_params[:song_id], playlist_id: playlist_params[:id])
    @playlist_song.delete

    redirect_to @playlist_song.playlist
  end

  def sort
    playlist_params = params.permit(:field, :id)
    @playlist_song_ids = PlaylistSong.where(playlist_id: playlist_params[:id]).pluck('song_id')

    @field = playlist_params[:field]
    @songs = Song.where(id: @playlist_song_ids).order(@field)

    respond_to do |format|
      format.json {render :json => @songs}
    end
  end

  def shuffle
    playlist_params = params.permit(:id)
    @playlist_song_ids = PlaylistSong.where(playlist_id: playlist_params[:id]).pluck('song_id')

    @field = playlist_params[:field]
    @songs = Song.where(id: @playlist_song_ids).shuffle

    respond_to do |format|
      format.json {render :json => @songs}
    end
  end
end
