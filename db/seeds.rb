# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([
  {
    name: "De Wet Blomerus",
    email: "dewet@example.com",
    password: "secret",
    password_confirmation: "secret"
  },
  {
    name: "Marysol Blomerus",
    email: "marysol@example.com",
    password: "secret",
    password_confirmation: "secret"
  },
  {
    name: "Kenwin Fortuin",
    email: "kenwin@example.com",
    password: "secret",
    password_confirmation: "secret"
  },
  {
    name: "Jeremy Ramos",
    email: "jeremy@example.com",
    password: "secret",
    password_confirmation: "secret"
  },
  {
    name: "Alain Kalima",
    email: "alain@example.com",
    password: "secret",
    password_confirmation: "secret"
  }
])