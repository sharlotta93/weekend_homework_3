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

  def viewers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON tickets.customer_id = customers.id
           WHERE tickets.film_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.map{ |person| Customer.new(person)}
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    result = Sqlrunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    Sqlrunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

  def self.find_movie_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = Sqlrunner.run(sql, values)
    return result.map { |movie| Film.new(movie)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    Sqlrunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    result = Sqlrunner.run(sql)
    return result.map { |movie| Film.new(movie)}
  end




end
