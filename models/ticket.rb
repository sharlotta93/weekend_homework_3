require('pg')
require_relative('customer')
require_relative('film')
require_relative('../db/sqlrunner')


class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize(ticket)
    @id = ticket['id'].to_i if ticket['id']
    @customer_id = ticket['customer_id'].to_i
    @film_id = ticket['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    result = Sqlrunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
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
