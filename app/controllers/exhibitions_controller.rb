class ExhibitionsController < ApplicationController
  before_action :find_exhibition, only: :show

  def new
    @exhibition = Exhibition.new
  end

  def create
    @exhibition = Exhibition.new(params[:id])
    @exhibition.save
  end

  def index
    @exhibitions = Exhibition.all
    @exhibitions = Exhibition.geocoded

    @markers = @exhibitions.map do |exhibition|
      {
        lat: exhibition.latitude,
        lng: exhibition.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { exhibition: exhibition })      }
    end
  end

  def show
  end

private

  def find_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:address_street, :latitude, :longitude, :category, :title, :date_start, :date_end, :occurences, :contact_url, :address_name, :contact_twitter, :contact_phone, :description, :tags, :contact_mail, :lead_text, :contact_facebook, :cover_credit, :address_city, :price_detail, :price_type, :date_description, :address_zipcode)
  end
end
