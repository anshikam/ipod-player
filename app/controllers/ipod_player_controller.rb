class IpodPlayerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @songs = Song.all
    @playlists = Playlist.all
  end

  def new

  end

  def create
    @song = Song.new(params.require(:song).permit(:name, :artist))
    @song.save

    redirect_to songs_path
  end

  def destroy
    @destroy_params = params.permit(:id)
    @message = ""
    begin
      Song.destroy(@destroy_params[:id])
    rescue
      @message = "Song exists in a playlist. Remove from playlist first."
    end
    @songs = Song.all
    if @message.empty?
      redirect_to songs_path and return
    end
    respond_to do |format|
      format.json {render :json => @message}
    end
  end

  def sort
    @field = params.permit(:field)
    @songs = Song.order(@field[:field])

    respond_to do |format|
      format.json {render :json => @songs}
    end
  end

  def shuffle_all
    @songs = Song.all.shuffle

    respond_to do |format|
      format.json {render :json => @songs}
    end
  end

end
