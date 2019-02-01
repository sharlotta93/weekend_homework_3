require('pg')
require_relative('customer')
require_relative('film')
require_relative('../db/sqlrunner')


class Ticket

  def initialize(ticket)
    @id = ticket['id'].to_i if ticket['id']
    @customer_id = ticket['customer_id'].to_i
    @movie_id = ticket['customer_id'].to_i
  end



end
