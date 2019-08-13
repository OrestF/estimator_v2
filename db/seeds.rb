# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
administration = Organization.create(name: 'Administration')
user = User.find_or_initialize_by(email: 'falchuko@gmail.com', role: 'admin')
user.organization = administration
user.password = 'password'
user.save


coax = Organization.create(name: 'coax')
user = User.find_or_initialize_by(email: 'orest.f@coaxsoft.com', role: 'manager')
user.organization = coax
user.password = 'password'
user.save
