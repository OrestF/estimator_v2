# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
administration = Organization.find_or_create_by(name: 'Administration')
admin = User.find_or_initialize_by(email: 'falchuko@gmail.com', role: 'admin')
admin.organization = administration
admin.password = 'password'
admin.save


coax = Organization.find_or_create_by(name: 'coax')
user = User.find_or_initialize_by(email: 'orest.f@coaxsoft.com', role: 'organization_manager')
user.organization = coax
user.password = 'password'
user.save
