require('pg')
require_relative('../db/sql_runner')

class Album

  attr_reader :id, :title, :genre, :artist_id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums (
    title,
    genre,
    artist_id
    ) VALUES (
      $1, $2, $3
      )
    RETURNING id"
    values = [@title, @genre, @artist_id]
    results = SqlRunner.run(sql,values)
    @id = results[0]['id'].to_i()
  end

end
