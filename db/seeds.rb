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
Visit.destroy_all
Exhibition.destroy_all
# Exhibition.destroy_all
## Create users
 'Creating 5 fake users...'
user_array = [1,2,3,4,5]

#####

# Creating USER

#####

user_array.each do |i|
  user_email = "#{i}@test.com"
  username = Faker::GreekPhilosophers.name+"#{i}"
  bio = Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false)
  user = User.new(email: user_email, password: '123456', phone_number:'+33695141564', bio: bio, username: username)
  # file = URI.open('https://source.unsplash.com/100x100/?avatar')
  # user.avatar.attach(io: file, filename: "avatar#{i}", content_type: 'image/png')
  user.save!
end

#####

# Exhibitions

#####


puts "creating 1 exhib"

extensive_url ='https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=400&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'
url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=2&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'

exhib_serialized = open(url).read
exhibitions = JSON.parse(exhib_serialized)
#puts exhibitions
exhibitions["records"].each do |exhib|
  fields = exhib["fields"]

 latitude = fields["lat_lon"][0].present? ? exhib["fields"]["lat_lon"][0] : nil
 longitude = fields["lat_lon"][1].present? ? exhib["fields"]["lat_lon"][1] : nil
 address_street = fields["address_street"].present? ? fields["address_street"] : "Unknown"
 category = fields["category"].present? ? fields["category"] : "Unknown"
 title = fields["title"].present? ? fields["title"] : "Unknown"
 date_start = fields["date_start"].present? ? fields["date_start"] : nil
 date_end = fields["date_end"].present? ? fields["date_end"] : nil
 occurences = fields["occurrences"].present? ? fields["occurrences"] : "Unknown" #TBC
 contact_url = fields["contact_url"].present? ? fields["contact_url"] : "Unknown"
 address_name = fields["address_name"].present? ? fields["address_name"] : "Unknown"
 contact_twitter = fields["contact_twitter"].present? ? fields["contact_twitter"] : "Unknown" #TBC
 contact_phone = fields["contact_phone"].present? ? fields["contact_phone"] : "Unknown" #TBS
 description = fields["description"].present? ? fields["description"] : "Unknown"
 tags = fields["tags"].present? ? fields["tags"] : "Unknown"
 contact_mail = fields["contact_mail"].present? ? fields["contact_mail"] : "Unknown" #TBC
 lead_text = fields["lead_text"].present? ? fields["lead_text"] : "Unknown"
 cover_url = fields["cover_url"].present? ? fields["cover_url"] : "Unknown"
 contact_facebook = fields["contact_facebook"].present? ? fields["contact_facebook"] : "Unknown" #TBC
 cover_credit = fields["cover_credit"].present? ? fields["cover_credit"] : "Unknown"
 address_city = fields["address_city"].present? ? fields["address_city"] : "Unknown"
 price_detail = fields["price_detail"].present? ? fields["price_detail"] : "Unknown"
 price_type = fields["price_type"].present? ? fields["price_type"] : "Unknown"
 date_description = fields["date_description"].present? ? fields["date_description"] : "Unknown"
 address_zipcode = fields["address_zipcode"].present? ? fields["address_zipcode"] : "Unknown"
 puts external_id = fields["id"].present? ? fields["id"].to_i : nil

    exhibition_params = {
      latitude:latitude,
      longitude: longitude,
      address_street: address_street,
      category: category,
      title: title,
      date_start: date_start,
      date_end: date_end,
      occurences: occurences,
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
      external_id: external_id
    }
    Exhibition.find_or_initialize_by(exhibition_params).save

end



#####

# Creating visit
exhibs = Exhibition.all

exhibs.each do |ex|
  2.times do
    date = Faker::Date.forward(days: 10)
    information = Faker::Hipster.paragraph_by_chars(characters: 128, supplemental: false)
    visit = Visit.new(date: date, information: information, exhibitions_id: ex.id)
    visit.save!
  end

  1.times do
    information = Faker::Hipster.paragraph_by_chars(characters: 128, supplemental: false)
    date = Faker::Date.backward(days: 10)
    visit = Visit.new(date: date, information: information, exhibitions_id: ex.id)
    visit.save!
  end
end


# create_table "visits", force: :cascade do |t|
#     t.date "date"
#     t.text "information"
#     t.bigint "exhibitions_id", null: false
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.index ["exhibitions_id"], name: "index_visits_on_exhibitions_id"
#   end

#####

#####

# Creating Subscriptions

#####


# create_table "subscriptions", force: :cascade do |t|
#     t.boolean "subscribed"
#     t.bigint "users_id", null: false
#     t.bigint "visits_id", null: false
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.index ["users_id"], name: "index_subscriptions_on_users_id"
#     t.index ["visits_id"], name: "index_subscriptions_on_visits_id"

