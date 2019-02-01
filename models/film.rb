require('pg')
require_relative('ticket')
require_relative('customer')
require_relative('../db/sqlrunner')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(movie)
    @id = movie['id'].to_i if movie['id']
    @title = movie['title']
    @price = movie['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    result = Sqlrunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    Sqlrunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end


end
