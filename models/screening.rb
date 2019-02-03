require('pg')
require_relative('customer')
require_relative('film')
require_relative('ticket')
require_relative('../db/sqlrunner')

class Screening

  attr_reader :id
  attr_accessor :show_time, :film_id, :capacity

  def initialize(object)
    @id = object['id'] if object['id']
    @show_time = object['show_time']
    @film_id = object['film_id']
    @capacity = object['capacity'].to_i
  end

  def tickets_sold()
      sql = "SELECT screenings.*
             FROM screenings
             INNER JOIN films
             ON screenings.film_id = films.id
             INNER JOIN tickets
             ON tickets.screening_id = screenings.id
             WHERE screenings.id = $1"
      values = [@id]
      return Sqlrunner.run(sql, values).count
  end

  def number_of_viewers()
    return viewers.count()
  end

  def viewers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON tickets.screening_id = customers.id
           WHERE tickets.screening_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.map{ |person| Customer.new(person)}
  end

  def save()
    sql = "INSERT INTO screenings (show_time, film_id, capacity) VALUES ($1, $2, $3) RETURNING id"
    values = [@show_time, @film_id, @capacity]
    result = Sqlrunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (show_time, film_id, capacity) = ($1, $2) WHERE id = $3"
    values = [@show_time, @film_id, @capacity, @id]
    Sqlrunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

  def self.find_screening_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = Sqlrunner.run(sql, values)
    return result.map { |movie| Screening.new(movie)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    Sqlrunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    result = Sqlrunner.run(sql)
    return result.map { |movie| Screening.new(movie)}
  end

end
