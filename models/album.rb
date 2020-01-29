require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor :id, :title, :genre, :artist_id

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

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_data = results[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update()
    sql = "UPDATE FROM albums SET (
      title,
      genre,
      artist_id
    ) =
    (
      $1, $2, $3
      )
      WHERE id = $4"
      values = [@title, @genre, @artist_id, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM albums WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def delete_all()
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end
end
