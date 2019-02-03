require('pg')
require_relative('ticket')
require_relative('film')
require_relative('../db/sqlrunner')
require('pry')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(person)
    @id = person['id'].to_i if person['id']
    @name = person['name']
    @funds = person['funds'].to_i
  end

  def pay_for_ticket(ticket)
    if @funds >= ticket.get_price
       @funds -= ticket.get_price
       return self #if I want to be able to update it straight away I have to make sure an object is returned and not an integer (method chaining)
    else
      nil
    end
  end

  def buy_ticket(ticket, screening)
    self.pay_for_ticket(ticket) if screening.tickets_sold < screening.capacity
  end

#in all tickets I have to combine customer with ticket and with screening and with id to be able to access the title of the movie and not just id
  def all_tickets()
    sql = "SELECT customers.name, films.title, tickets.id
           FROM tickets
           INNER JOIN customers
           ON tickets.customer_id = customers.id
           INNER JOIN screenings
           ON tickets.screening_id = screenings.id
           INNER JOIN films
           ON screenings.film_id = films.id
           WHERE customers.id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.each {|info| p info}
  end

  def films()
    sql = "SELECT screenings.*
           FROM screenings
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = Sqlrunner.run(sql, values)
    return result.map{ |movie| Screening.new(movie)}
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = Sqlrunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    Sqlrunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    Sqlrunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    Sqlrunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = Sqlrunner.run(sql)
    return result.map { |person| Customer.new(person)}
  end


end
