require('pry')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')



customer_1 = Customer.new({
  'name' => 'Fred',
  'funds' => 100
})

customer_2 = Customer.new({
  'name' => 'Jessie',
  'funds' => 10
})

customer_3 = Customer.new({
  'name' => 'Sandy',
  'funds' => 50
})

customer_1.save()
customer_2.save()
customer_3.save()

film_1 = Film.new({
  'title' => 'Fast and Furious',
  'price' => 10
})

film_2 = Film.new({
  'title' => 'Verdigo',
  'price' => 12
})

film_3 = Film.new({
  'title' => '24 Hours- Marathon',
  'price' => 30
})

film_1.save()
film_2.save()
film_3.save()

ticket_1 = Ticket.new({
  'customer_id' => customer_3.id,
  'film_id' => film_2.id
})

ticket_2 = Ticket.new({
  'customer_id' => customer_3.id,
  'film_id' => film_3.id
})

ticket_3 = Ticket.new({
  'customer_id' => customer_1.id,
  'film_id' => film_3.id
})

ticket_1.save()
ticket_2.save()
ticket_3.save()

binding.pry
nil
