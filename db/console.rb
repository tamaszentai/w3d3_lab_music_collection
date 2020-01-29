require("pry")
require_relative('../models/artist')
require_relative('../models/album')

artist1 = Artist.new({
  'name' => 'Tamas'
  })

artist1.save()

album1 = Album.new({
  'title' => 'Closer',
  'genre' => 'pop',
  'artist_id' => artist1.id
  })

album1.save()

binding.pry
nil
