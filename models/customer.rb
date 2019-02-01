require('pg')
require_relative('ticket')
require_relative('film')
require_relative('../db/sqlrunner')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(person)
    @id = person['id'].to_i if person['id']
    @name = person['name']
    @funds = person['funds'].to_i
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
