terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.SPOTIFY_API_KEY
}

data "spotify_search_track" "RAM" {
  album = "Random Access Memories (10th Anniversary Edition)"
  limit = 7
}

data "spotify_search_track" "LImperatrice" {
  artist = "L'Impératrice"
  limit = 7
}

data "spotify_search_track" "Odyssee" {
  album = "Odyssee EP"
}

data "spotify_search_track" "Parcels" {
  artist = "Parcels"
  limit = 7
}

data "spotify_track" "Zenith" {
  url = "https://open.spotify.com/track/0qKX14YZHptDWiEN0CgxGz?si=174ddb3f25414e2c"
}

data "spotify_track" "A_View_To_Kill" {
  url = "https://open.spotify.com/track/7fN3QQtmCMkiczQ41IuhwK?si=d0e32a11da1f4c72"
}

data "spotify_track" "Veridis_Quo" {
  url = "https://open.spotify.com/track/2LD2gT7gwAurzdQDQtILds?si=392db9f1e95849e6"
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
    data.spotify_track.Zenith.id,
    data.spotify_track.A_View_To_Kill.id,
    data.spotify_track.Veridis_Quo.id
  ])
}
