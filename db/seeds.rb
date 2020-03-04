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


Like.destroy_all
Message.destroy_all
Participation.destroy_all
Subscription.destroy_all
User.destroy_all
Visit.destroy_all
Exhibition.destroy_all
# Exhibition.destroy_all
## Create users

if User.count < 15
  puts 'Creating 10 fake users...'
  user_array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]


  # Creating USER
  user_array.each do |i|
    user_email = "#{i}@test.com"
    username = Faker::GreekPhilosophers.name+"#{i}"
    bio = Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false)
    user = User.new(email: user_email, password: '123456', phone_number:'+33695141564', bio: bio, username: username)
    path = "app/assets/images/#{i}.jpg"
    file = File.open(path)
    user.avatar.attach(io: file, filename: "avatar#{i}")
    user.save!
    end
end

# #####

# # Exhibitions

# #####


puts "creating 30 exhib"

extensive_url ='https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=400&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'
url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=30&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'

exhib_serialized = open(url).read
exhibitions = JSON.parse(exhib_serialized)
#puts exhibitions
exhibitions["records"].each do |exhib|
  fields = exhib["fields"]

 address_street = fields["address_street"].present? ? fields["address_street"] : "Non précisé"
 address_city = fields["address_city"].present? ? fields["address_city"] : "Non précisé"
 full_address = "#{address_street}, #{address_city}"
 latitude = fields["lat_lon"][0].present? ? exhib["fields"]["lat_lon"][0] : nil
 longitude = fields["lat_lon"][1].present? ? exhib["fields"]["lat_lon"][1] : nil
 address_street = fields["address_street"].present? ? fields["address_street"] : "Non précisé"
 category = fields["category"].present? ? fields["category"] : "Non précisé"
 title = fields["title"].present? ? fields["title"] : "Non précisé"
 date_start = fields["date_start"].present? ? fields["date_start"] : nil
 date_end = fields["date_end"].present? ? fields["date_end"] : nil
 occurences = fields["occurrences"].present? ? fields["occurrences"] : "Non précisé" #TBC
 contact_url = fields["contact_url"].present? ? fields["contact_url"] : "Non précisé"
 address_name = fields["address_name"].present? ? fields["address_name"] : "Non précisé"
 contact_twitter = fields["contact_twitter"].present? ? fields["contact_twitter"] : "Non précisé" #TBC
 contact_phone = fields["contact_phone"].present? ? fields["contact_phone"] : "Non précisé" #TBS
 # description = fields["description"].present? ? ActionView::Base.full_sanitizer.sanitize(fields["description"]) : "Non précisé"
 description = fields["description"].present? ? fields["description"] : "Non précisé"
 tags = fields["tags"].present? ? fields["tags"] : "Non précisé"
 contact_mail = fields["contact_mail"].present? ? fields["contact_mail"] : "Non précisé" #TBC
 lead_text = fields["lead_text"].present? ? fields["lead_text"] : "Non précisé"
 cover_url = fields["cover_url"].present? ? fields["cover_url"] : "Non précisé"
 contact_facebook = fields["contact_facebook"].present? ? fields["contact_facebook"] : "Non précisé" #TBC
 cover_credit = fields["cover_credit"].present? ? fields["cover_credit"] : "Non précisé"
 price_detail = fields["price_detail"].present? ? fields["price_detail"] : "Non précisé"
 price_type = fields["price_type"].present? ? fields["price_type"] : "Non précisé"
 # date_description = fields["date_description"].present? ? ActionView::Base.full_sanitizer.sanitize(fields["date_description"]) : "Non précisé"
 date_description = fields["date_description"].present? ? fields["date_description"] : "Non précisé"
 address_zipcode = fields["address_zipcode"].present? ? fields["address_zipcode"] : "Non précisé"
 external_id = fields["id"].present? ? fields["id"].to_i : nil
 new_occurences = occurences.split(";")
 new_occurences.map! do |day|
  day.split("_")
 end
    exhibition_params = {
      latitude:latitude,
      longitude: longitude,
      address_street: address_street,
      category: category,
      title: title,
      date_start: date_start,
      date_end: date_end,
      occurences: new_occurences,
      contact_url: contact_url,
      address_name: address_name,
      contact_twitter: contact_twitter,
      contact_phone: contact_phone,
      description: description,
      tags: tags,
      contact_mail: contact_mail,
      lead_text: lead_text,
      cover_url: cover_url,
      contact_facebook: contact_facebook,
      cover_credit: cover_credit,
      address_city: address_city,
      price_detail: price_detail,
      price_type: price_type,
      date_description: date_description,
      address_zipcode: address_zipcode,
      external_id: external_id,
      full_address: full_address
    }
    Exhibition.find_or_initialize_by(exhibition_params).save
    exhibition = Exhibition.find_by(external_id: external_id)
    photo_file = URI.open(cover_url)
    exhibition.photo.attach(io: photo_file, filename: "#{external_id}_cover")
    exhibition.save!

end



# #####

# # Creating visit

# #####

puts "creating 2 to 5 visits / exhib"
exhibs = Exhibition.all

exhibs.each do |ex|
  random_number = [1,2,3,4].sample(1)
  random_number[0].times do
    date = Faker::Date.forward(days: 10)
    information = "Bonjour,
je suis spécialiste du thème abordé dans cette exposition et me ferai une joie de partager mes connaissances avec ceux qui le désirent”.
A très vite"
    time = rand(ex.date_start..ex.date_end)
    meeting_hour = Time.parse(time.split(" ").last)
    visit = Visit.new(date: date, information: information, exhibition_id: ex.id, meeting_hour: meeting_hour)
    visit.save!
  end

  1.times do
    information = Faker::Hipster.paragraph_by_chars(characters: 128, supplemental: false)
    date = Faker::Date.backward(days: 10)
    time = rand(ex.date_start..ex.date_end)
    meeting_hour = Time.parse(time.split(" ").last)
    visit = Visit.new(date: date, information: information, exhibition_id: ex.id, meeting_hour: meeting_hour)
    visit.save!
  end
end



# #####

# # Creating Subscription

# #####

puts "creating 2 subscribers per visit"


visits = Visit.all
users = User.all
subscriptions = Subscription.all
user1 = users.sample(1)
new_users = users - user1
user2 = new_users.sample(1)

visits.each do |visit|


#je prends un nombre de 1 à 6
random_number = [1,2,3,4,5,6].sample(1)

  random_number[0].times do
   user_selected = users.sample(1)
  users = users - user_selected
new_users = users - user1
user2 = new_users.sample(1)


  # unless subscriptions.where(user_id: user1.first.id, visit_id: visit.id)
    sub1 = Subscription.new(
      subscribed: "true",
      user_id: user1.first.id,
      visit_id: visit.id
      )
    sub1.save!

  # else
  #   puts "Subscirption for user 1 already exit"
  # end
   # unless subscriptions.where(user_id: user2.first.id, visit_id: visit.id)
    # sub2 = Subscription.new(
    #   subscribed: "true",
    #   user_id: user2.first.id,
    #   visit_id: visit.id
    #   )
    # sub2.save!
  # end
end

####

# Creating Participation

####

puts "creating between 3 and 10 reviews per exhibition"

exhibs.each do |exhib|
  Random.new.rand(3..10).times do
    date = Faker::Date.backward(days: 20)
    review_content = Faker::Quote.famous_last_words
    rating = Random.new.rand(2..5)
    interested = Faker::Boolean.boolean
    user = User.all.sample
    participation = Participation.new(date: date, review_content: review_content, rating: rating, interested: interested, exhibition_id: exhib.id, user_id: user.id)
    participation.save!
  end
end




