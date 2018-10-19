require 'rspotify'

RSpotify.authenticate(ENV['SPOTIFY_KEY1'], ENV['SPOTIFY_KEY2'])

artists = RSpotify::Artist.search('bad plus')
#artists = RSpotify::Artist.search(ARGV[0])

artist = artists.first
p artist.name
p artist.popularity

albums = artist.albums
album = albums.first
p album.name
p album.release_date
p album.images

tracks = album.tracks
track = tracks.first
p track.name
p track.duration_ms
p track.track_number
p track.preview_url
