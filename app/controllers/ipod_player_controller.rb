class IpodPlayerController < ApplicationController
  def index
    @songs = Song.all
  end

  def new

  end

  def create
    @song = Song.new(params.require(:song).permit(:name, :artist))
    @song.save

    redirect_to songs_path
  end

  def delete
    Song.destroy(params.require(:song).permit(:id))
    redirect_to songs_path
  end

end
