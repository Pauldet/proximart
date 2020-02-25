class CreateExhibitions < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibitions do |t|
      t.string :address_street
      t.float :latitude
      t.float :longitude
      t.string :category
      t.string :title
      t.date :date_start
      t.date :date_end
      t.date :occurences
      t.string :contact_url
      t.string :address_name
      t.string :contact_twitter
      t.string :contact_phone
      t.text :description
      t.string :tags
      t.string :contact_mail
      t.string :lead_text
      t.string :cover_url
      t.string :contact_facebook
      t.string :cover_credit
      t.string :address_city
      t.string :price_detail
      t.string :price_type
      t.string :date_description
      t.string :address_zipcode

      t.timestamps
    end
  end
end
