require('pry')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

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

screening1 = Screening.new({
  'show_time' => '14:55',
  'film_id' => film_3.id,
  'capacity' => 50
  })

screening2 = Screening.new({
  'show_time' => '16:55',
  'film_id' => film_2.id,
  'capacity' => 30
})

screening3 = Screening.new({
  'show_time' => '15:55',
  'film_id' => film_1.id,
  'capacity' => 40
})

screening1.save()
screening2.save()
screening3.save()

ticket_1 = Ticket.new({
  'customer_id' => customer_1.id,
  'screening_id' => screening3.id
})

ticket_2 = Ticket.new({
  'customer_id' => customer_3.id,
  'screening_id' => screening1.id
})

ticket_3 = Ticket.new({
  'customer_id' => customer_1.id,
  'screening_id' => screening2.id
})

ticket_4 = Ticket.new({
  'customer_id' => customer_2.id,
  'screening_id' => screening3.id
})

ticket_5 = Ticket.new({
  'customer_id' => customer_3.id,
  'screening_id' => screening2.id
})



ticket_1.save()
ticket_2.save()
ticket_3.save()
ticket_4.save()
ticket_5.save()

customer_1.name = "Barbara"
customer_1.update()

film_2.price = 11
film_2.update()

# ticket_1.screening_id = screening1.id
# ticket_1.update

#all three functions work
# customer_2.delete()
# film_3.delete()
# ticket_2.delete()

customers = Customer.all()
movies = Film.all()
tickets = Ticket.all()
screenings = Screening.all()

# films = customer_3.films()
# people = film_3.viewers()
#
# customer_1.pay_for_ticket(ticket_3).update()
#
# m = Film.find_movie_by_id(19)

binding.pry
nil
