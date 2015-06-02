# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([
  {
    first_name: "De Wet",
    last_name: "Blomerus",
    mobile_number: "0792958514",
    password: "secret",
    password_confirmation: "secret"
  },
  {
    first_name: "Marysol",
    last_name: "Blomerus",
    mobile_number: "0722857438",
    password: "secret",
    password_confirmation: "secret"
  },
])
