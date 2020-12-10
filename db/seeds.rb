# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

users = [
  { first_name: 'Ted', last_name: 'Lasso', email: 'ted@footballislife.com' },
  { first_name: 'Coach', last_name: 'Beard', email: 'beard@footballislife.com' },
  { first_name: 'Keeley', last_name: 'Jones', email: 'keeley@footballislife.com' },
  { first_name: 'Leslie', last_name: 'Higgins', email: 'higgins@footballislife.com' },
  { first_name: 'Rebecca', last_name: 'Welton', email: 'rebecca@footballislife.com' },
  { first_name: 'Roy', last_name: 'Kent', email: 'roy@footballislife.com' },
  { first_name: 'Dani', last_name: 'Rojas', email: 'dani.rojas.rojas@footballislife.com' },
  { first_name: 'Jamie', last_name: 'Tartt', email: 'jamie@footballislife.com' }
]

users.each do |user|
  User.create!(user)
end
