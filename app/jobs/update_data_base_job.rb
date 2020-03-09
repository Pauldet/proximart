class UpdateDataBaseJob < ApplicationJob
  queue_as :default

  def perform
    url ='https://opendata.paris.fr/api/records/1.0/search/?dataset=que-faire-a-paris-&rows=300&facet=category&facet=tags&facet=address_zipcode&facet=address_city&facet=pmr&facet=access_type&facet=price_type&refine.category=Expositions+'
    exhib_serialized = open(url).read
    exhibitions = JSON.parse(exhib_serialized)
    exhibitions["records"].each do |exhib|
      fields = exhib["fields"]
      if fields["lat_lon"].present?
        if fields["lat_lon"][0].present? && fields["lat_lon"][1].present? && fields["date_start"].present? && fields["date_end"].present?
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
          description = fields["description"].present? ? fields["description"] : "Non précisé"
          tags = fields["tags"].present? ? fields["tags"] : "Non précisé"
          contact_mail = fields["contact_mail"].present? ? fields["contact_mail"] : "Non précisé" #TBC
          lead_text = fields["lead_text"].present? ? fields["lead_text"] : "Non précisé"
          cover_url = fields["cover_url"].present? ? fields["cover_url"] : "Non précisé"
          contact_facebook = fields["contact_facebook"].present? ? fields["contact_facebook"] : "Non précisé" #TBC
          cover_credit = fields["cover_credit"].present? ? fields["cover_credit"] : "Non précisé"
          price_detail = fields["price_detail"].present? ? fields["price_detail"] : "Non précisé"
          price_type = fields["price_type"].present? ? fields["price_type"] : "Non précisé"
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
          unless Exhibition.find_by( external_id: external_id)
            puts "creating 1 exhib"
            Exhibition.find_or_initialize_by(exhibition_params).save
            exhibition = Exhibition.find_by(external_id: external_id)
            photo_file = URI.open(cover_url)
            exhibition.photo.attach(io: photo_file, filename: "#{external_id}_cover")
            exhibition.save!
            puts "Exhib created id: #{exhibition.id}"
          end
        end
      end
    end
  end
end
