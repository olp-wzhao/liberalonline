# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
  email: 'admin@example.com',
  first_name: 'Sample', 
  last_name: 'User', 
  roles: ['admin'], 
  postal_code: 'M2H2N1'
  password: 'ontario10',
  password_confirmation: 'ontario10'
)
admin.skip_confirmation!
admin.save!

user = User.new(
  email: 'jessenaiman@gmail.com',
  first_name: 'Jesse', 
  last_name: 'Naiman', 
  roles: ['user'], 
  postal_code: 'M2H2N1'
  password: 'ontario10',
  password_confirmation: 'ontario10'
)
user.skip_confirmation!
user.save