class Song < ApplicationRecord
  validates :name, presence: true
  validates :artist, presence: true

  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
end
