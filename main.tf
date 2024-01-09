terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = env.SPOTIFY_API_KEY
}

data "spotify_search_track" "by_artist" {
  # artist = "Daft Punk"
  album = "Random Access Memories (10th Anniversary Edition)"
  #  name  = "Give Life Back to Music"
}

resource "spotify_playlist" "playlist" {
  name        = "The CodeJam Playlist"
  description = "Wishing you make the nicest, most Randomly Accessible Memories this CodeR̶A̶M̶Jam :)"
  public      = true

  tracks = [
    data.spotify_search_track.by_artist.tracks[0].id,
    data.spotify_search_track.by_artist.tracks[1].id,
    data.spotify_search_track.by_artist.tracks[2].id,
  ]
}
