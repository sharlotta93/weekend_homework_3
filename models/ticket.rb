require('pg')
require_relative('customer')
require_relative('film')
require_relative('../db/sqlrunner')
require_relative('screening')


class Ticket

  attr_reader :id
  attr_accessor :screening_id, :customer_id

  def initialize(ticket)
    @id = ticket['id'].to_i if ticket['id']
    @customer_id = ticket['customer_id'].to_i
    @screening_id = ticket['screening_id'].to_i
  end

  def get_price()
    sql = "SELECT films.price
           FROM films
           INNER JOIN screenings
           ON screenings.film_id = films.id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE screening_id = $1"
    values = [@screening_id]
    return Sqlrunner.run(sql, values)[0]['price'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @screening_id]
    result = Sqlrunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, screening_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    Sqlrunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    Sqlrunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = Sqlrunner.run(sql)
    return result.map { |info| Ticket.new(info)}
  end


end
