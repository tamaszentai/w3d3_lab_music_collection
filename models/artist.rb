require('PG')
require_relative('../db/sql_runner')
class Artist

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i() if options ['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO ARTISTS
    (
    name
    )
    VALUES
    (
      $1
      )
      RETURNING id"
      values = [@name]
      results = SqlRunner.run(sql, values)
      @id = results[0]['id'].to_i()
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map {|album| Album.new(album)}
    return albums
  end

  def update()
    sql = "UPDATE FROM albums SET (
      name
    ) =
    (
      $1
      )
      WHERE id = $2"
      values = [@name, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM artists WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def delete_all()
      sql = "DELETE FROM artists"
      SqlRunner.run(sql)
    end

end
