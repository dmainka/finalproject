# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

all_user_data = [
  { :name => "Daniel Mainka", :email => "dmainka@gmail.com", :password => "password",  :password_confirmation => "password", :admin => true},
  { :name => "Customer1", :email => "customer1@example.com", :password => "password",  :password_confirmation => "password", :admin => false},
  { :name => "Customer2", :email => "customer2@example.com", :password => "password",  :password_confirmation => "password", :admin => false}
]

User.destroy_all
all_user_data.each do |user_info|
  u = User.new
  u.name = user_info[:name]
  u.email = user_info[:email]
  u.password = user_info[:password]
  u.password_confirmation = user_info[:password_confirmation]
  u.admin = user_info[:admin]
  u.save
end
