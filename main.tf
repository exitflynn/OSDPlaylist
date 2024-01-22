terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

variable "SPOTIFY_API_KEY" {
  type 		= string
  description 	= "The spotify API key, post authentication"
}

provider "spotify" {
  api_key = var.SPOTIFY_API_KEY
}

data "spotify_search_track" "RAM" {
  # artist = "Daft Punk"
  album = "Random Access Memories (10th Anniversary Edition)"
  limit = 8
}

data "spotify_search_track" "LImperatrice" {
  artist = "L'Impératrice"
  limit = 10
}

data "spotify_search_track" "Odyssee" {
  album = "Odyssee EP"
}

data "spotify_search_track" "Parcels" {
  artist = "Parcels"
  limit = 8
}

resource "spotify_playlist" "playlist" {
  name        = "The CodeJam Playlist"
  description = "Wishing you make the nicest, most Randomly Accessible Memories this CodeR̶A̶M̶Jam :)"
  public      = true

  tracks = flatten([
    data.spotify_search_track.RAM.tracks[*].id,
    data.spotify_search_track.LImperatrice.tracks[*].id,
    data.spotify_search_track.Odyssee.tracks[*].id,
    data.spotify_search_track.Parcels.tracks[*].id,
  ])
}
