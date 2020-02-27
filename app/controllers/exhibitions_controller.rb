class ExhibitionsController < ApplicationController
  before_action :find_exhibition, only: :show



def show
    @visits = @exhibition.visits
    # @futur_visits = Visit.where(exhibition_id: @exhibition.id AND DateTime.now =< :date) We need to add the logic of future and past events
    # @past_visits = Visit.where(exhibition_id: @exhibition.id AND DateTime.now >= :date)
    @participations = @exhibition.participations


  end


  def new
    @exhibition = Exhibition.new()
  end

  def create
    @exhibition = Exhibition.new(params[:id])
    @exhibition.save
  end

  def index
    @exhibitions = Exhibition.geocoded
    @tags = @exhibitions.map{|e| e.tags.split(';')}.flatten.compact.uniq

    @markers = @exhibitions.map do |exhibition|
      {
        lat: exhibition.latitude,
        lng: exhibition.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { exhibition: exhibition })
      }
    end
  end

  def update
    @exhibition_array = Exhibition.where(external_id: external_id)
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

  end

private

  def find_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:address_street, :latitude, :longitude, :category, :title, :date_start, :date_end, :occurences, :contact_url, :address_name, :contact_twitter, :contact_phone, :description, :tags, :contact_mail, :lead_text, :contact_facebook, :cover_credit, :address_city, :price_detail, :price_type, :date_description, :address_zipcode, :external_id)
  end

end
