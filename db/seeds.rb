# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'json'
require 'open-uri'
require 'faker'

User.destroy_all
## Create users
puts 'Creating 5 fake users...'
user_array = [1,2,3,4,5]

user_array.each do |i|
  user_email = "#{i}@test.com"
  username = Faker::GreekPhilosophers.name+"#{i}"
  bio = Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false)
  user = User.new(email: user_email, password: '123456', phone_number:'+33695141564', bio: bio)
  file = URI.open('https://source.unsplash.com/100x100/?avatar')
  user.avatar.attach(io: file, filename: "avatar#{i}", content_type: 'image/png')
  user.save!
end






# url = 'https://api.github.com/users/ssaunier'
# user_serialized = open(url).read
# user = JSON.parse(user_serialized)

# puts "#{user['name']} - #{user['bio']}"
