# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if God.any_in(email: ['god@workplay.in']).empty?
	God.create!(email: 'god@workplay.in', password: 'kRdR1BLDrZ', password_confirmation: 'kRdR1BLDrZ')
end
