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
Exhibition.destroy_all
## Create users
 'Creating 5 fake users...'
# user_array = [1,2,3,4,5]

# user_array.each do |i|
#   user_email = "#{i}@test.com"
#   username = Faker::GreekPhilosophers.name+"#{i}"
#   bio = Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false)
#   user = User.new(email: user_email, password: '123456', phone_number:'+33695141564', bio: bio, username: username)
#   # file = URI.open('https://source.unsplash.com/100x100/?avatar')
#   # user.avatar.attach(io: file, filename: "avatar#{i}", content_type: 'image/png')
#   user.save!
# end

puts "creating 1 exhib"

extensive_url ='https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=400&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'
url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=2&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'

exhib_serialized = open(url).read
exhibitions = JSON.parse(exhib_serialized)
#puts exhibitions
exhibitions["records"].each do |exhib|
  fields = exhib["fields"]

# puts latitude = fields["lat_lon"][0].present? ? exhib["fields"]["lat_lon"][0] : nil
# puts longitude = fields["lat_lon"][1].present? ? exhib["fields"]["lat_lon"][1] : nil
# puts address_street = fields["address_street"].present? ? fields["address_street"] : "Unknown"
# puts category = fields["category"].present? ? fields["category"] : "Unknown"
# puts title = fields["title"].present? ? fields["title"] : "Unknown"
# puts date_start = fields["date_start"].present? ? fields["date_start"] : nil
# puts date_end = fields["date_end"].present? ? fields["date_end"] : nil
# puts occurences = fields["occurrences"].present? ? fields["occurrences"] : "Unknown" #TBC
# puts contact_url = fields["contact_url"].present? ? fields["contact_url"] : "Unknown"
# puts address_name = fields["address_name"].present? ? fields["address_name"] : "Unknown"
# puts contact_twitter = fields["contact_twitter"].present? ? fields["contact_twitter"] : "Unknown" #TBC
# puts contact_phone = fields["contact_phone"].present? ? fields["contact_phone"] : "Unknown" #TBS
# puts description = fields["description"].present? ? fields["description"] : "Unknown"
# puts tags = fields["tags"].present? ? fields["tags"] : "Unknown"
# puts contact_mail = fields["contact_mail"].present? ? fields["contact_mail"] : "Unknown" #TBC
# puts lead_text = fields["lead_text"].present? ? fields["lead_text"] : "Unknown"
# puts cover_url = fields["cover_url"].present? ? fields["cover_url"] : "Unknown"
# puts contact_facebook = fields["contact_facebook"].present? ? fields["contact_facebook"] : "Unknown" #TBC
# puts cover_credit = fields["cover_credit"].present? ? fields["cover_credit"] : "Unknown"
# puts address_city = fields["address_city"].present? ? fields["address_city"] : "Unknown"
# puts price_detail = fields["price_detail"].present? ? fields["price_detail"] : "Unknown"
# puts price_type = fields["price_type"].present? ? fields["price_type"] : "Unknown"
# puts date_description = fields["date_description"].present? ? fields["date_description"] : "Unknown"
# puts address_zipcode = fields["address_zipcode"].present? ? fields["address_zipcode"] : "Unknown"
# puts external_id = fields["id"].present? ? fields["id"].to_i : nil

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

  # if Exhibition.where(external_id: external_id)
  #   @exhibition_array = Exhibition.where(external_id: external_id)
  #   @exhibition = @exhibition_array[0]
  #   @exhibition.update(
  #   latitude:latitude,
  #   longitude: longitude,
  #   address_street: address_street,
  #   category: category,
  #   title: title,
  #   date_start: date_start,
  #   date_end: date_end,
  #   occurences: occurences,
  #   contact_url: contact_url,
  #   address_name: address_name,
  #   contact_twitter: contact_twitter,
  #   contact_phone: contact_phone,
  #   description: description,
  #   tags: tags,
  #   contact_mail: contact_mail,
  #   lead_text: lead_text,
  #   cover_url: cover_url,
  #   contact_facebook: contact_facebook,
  #   cover_credit: cover_credit,
  #   address_city: address_city,
  #   price_detail: price_detail,
  #   price_type: price_type,
  #   date_description: date_description,
  #   address_zipcode: address_zipcode)
  #   puts @exhibition
  #   puts @exhibition.valid?
  #   puts "test true"

  # else
    @exhibition = Exhibition.new(
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
      external_id: external_id)
    puts @exhibition.valid?
    puts @exhibition
    @exhibition.save!
  # end

end


