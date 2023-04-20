require 'faker'

include ApplicationHelper
pass1 = ApplicationHelper.generate_password
admin1 = User.create(name: 'admin1', email: 'admin1@blockbuster.com', password: pass1)
p "Admin1 credentials #{admin1.email} - #{pass1}"
pass2 = ApplicationHelper.generate_password
admin2 = User.create(name: 'admin2', email: 'admin2@blockbuster.com', password: pass2)
p "Admin2 credentials #{admin2.email} - #{pass2}"

genres = ['Acción', 'Drama', 'Comedia', 'Ciencia Ficción', 'Documental']
cycler = genres.cycle
100.times do
  Api::V1::Movie.create(
    title: Faker::Movie.title,
    description: Faker::Movie.quote,
    gender: cycler.next,
    release_date: Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now,
                                             excepted: Date.today),
    added_date: Faker::Date.between_except(from: 2.year.ago, to: 1.month.ago, excepted: Date.today),
    daily_rental_price: Faker::Number.decimal(l_digits: 2),
    available: Faker::Boolean.boolean
  )
end
p 'Movies loaded'
