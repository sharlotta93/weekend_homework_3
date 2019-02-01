require('pg')
require_relative('ticket')
require_relative('film')
require_relative('../db/sqlrunner')


class Customer

  def initialize(person)
    @id = person['id'].to_i if person['id']
    @name = person['name']
    @funds = person['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers(name, funds) VALUES($1, $2) RETURNING id"
    values = [@name, @funds]
    result = Sqlrunner.run(sql, values).first
    @id = result[0]['id'].to_i
  end



end
