require 'faker'

include ApplicationHelper
pass1 = ApplicationHelper.generate_password
admin1 = User.create(name: 'admin1', email: 'admin1@blockbuster.com', password: pass1)
p "Admin1 credentials #{admin1.email} - #{pass1}"
pass2 = ApplicationHelper.generate_password
admin2 = User.create(name: 'admin2', email: 'admin2@blockbuster.com', password: pass2)
p "Admin2 credentials #{admin2.email} - #{pass2}"

user_pass = ApplicationHelper.generate_password
all_users = []
10.times do |i|
  all_users << User.create(name: Faker::Name.name, email: "user#{i}@blockbuster.com",
                           password: user_pass)
end
users_cycler = all_users.cycle
p "All users credentials user[0-9]@blockbuster.com - #{user_pass}"

genres = ['Acción', 'Drama', 'Comedia', 'Ciencia Ficción', 'Documental']
genres_cycler = genres.cycle
all_movies = []
100.times do
  all_movies << Api::V1::Movie.create(
    title: Faker::Movie.title,
    description: Faker::Movie.quote,
    gender: genres_cycler.next,
    release_date: Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now,
                                             excepted: Date.today),
    added_date: Faker::Date.between_except(from: 2.year.ago, to: 1.month.ago, excepted: Date.today),
    daily_rental_price: Faker::Number.decimal(l_digits: 2),
    available: Faker::Boolean.boolean
  )
end
movies_cycler = all_movies.cycle
p 'Movies loaded'

100.times do |_i|
  rent_date = Faker::Date.between_except(from: 1.month.ago, to: 1.day.ago, excepted: Date.today)

  rent_period = rand(5)
  movie = movies_cycler.next

  Api::V1::Rent.create(user: users_cycler.next, movie: movie, rent_date: rent_date,
                       rent_period: rent_period)
end

p 'rents loaded'
