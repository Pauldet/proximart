class ExhibitionsController < ApplicationController
  before_action :find_exhibition, only: [:show, :like, :update_average_rating]



def show
    @visits = @exhibition.visits
    # @futur_visits = Visit.where(exhibition_id: @exhibition.id AND DateTime.now =< :date) We need to add the logic of future and past events
    # @past_visits = Visit.where(exhibition_id: @exhibition.id AND DateTime.now >= :date)
    @participations = @exhibition.participations
    # @ratings_count = 0
    # sum = 0
    # @participations.each do |participation|
    #   sum += participation.rating
    #   @ratings_count += 1
    # end
    # if @ratings_count != 0
    #   @average_rating = sum.fdiv(@ratings_count).truncate(2)
    # end
  end

def like
  exhibition_like = current_user.likes.find_by(exhibition_id: @exhibition.id)
  if exhibition_like
    exhibition_like.destroy
  else
    Like.create(exhibition: @exhibition, user: current_user)
  end
  redirect_to exhibition_path(@exhibition)
end

  def new
    @exhibition = Exhibition.new()
  end

  def create
    @exhibition = Exhibition.new(params[:id])
    @exhibition.save
  end

  def index
    @allExhibitions = Exhibition.all
    # if params[:last_days] == '1'
    #   @allExhibitions = @allExhibitions.where("XXXXXX BETWEEN XXXX ?  ?", Date.current, Date.current.end_of_week)
    # end
    # @categories = @allExhibitions.map{|e| e.category.split[2]}.compact.uniq.reject{|s| s == "Autre"}.sort

    @selected_categories = params[:categories].presence

    @categories = Exhibition.select('distinct category').
      where.not(category: 'Expositions -> Autre expo').
      order('category').
      pluck(:category).
      uniq.
      map { |category| category.gsub('Expositions -> ', '') }

    if params[:distanceRange]
      @maxdistance = params[:distanceRange].to_i
    else
      @maxdistance = 1
    end

    if params[:search]
      @current_location = [params[:search][:lat], params[:search][:long]]
    else
     @current_location = [48.877932,2.3417265]
    end

    @distanceEx = {} #hash of expo id => distance from current position, with only exhibition closer than maxdistance
    @distanceExWithUnit = {} #hash of expo id => distance from current position, with only exhibition closer than maxdistance + Merters or Kms

    @allExhibitions.each do |exhibition|
      dist = Geocoder::Calculations.distance_between(@current_location, exhibition)
      id = exhibition.id
      if dist < @maxdistance
        @distanceEx[id] = dist.truncate(2)
        if dist < 1
          distance = dist.truncate(1)*1000
          diststring = distance.truncate(0)
          distancewithunit = "#{diststring} m"

        else
          disttrunc = dist.truncate(0)
          if dist - disttrunc < 0.05
            distancewithunit = "#{dist.truncate(0)} km"
          else
            distancewithunit = "#{dist.truncate(1)} km"
          end
        end
        @distanceExWithUnit[id] = distancewithunit
      end
    end
    #creer un hash avec Exhibition instance et distance en value
    exhibId = @distanceEx.keys #ExhibId of Exhib closer than max range
    @exhibitionsUnsorted = Exhibition.all.where(id: exhibId)
    @exhibitionsArrayWithDistance = @exhibitionsUnsorted.map{|exhib| [exhib, @distanceEx[exhib.id]]}.sort_by{|a| a[1]}
    @exhibitions = @exhibitionsArrayWithDistance.map{|a| a[0]}
    # @tags = @allExhibitions.map{|e| e.tags.split(';')}.flatten.compact.uniq # --> if we need to search with tags

    if params[:search] && params[:search][:opened] != '0'
      @exhibitions = @exhibitions.select { |ex| ex.opened?(Time.now) }
    end

    if @selected_categories
      @allExhibitionsWithCat = @exhibitions.map{|ex| [ex,ex.category.gsub('Expositions -> ', '')]}
      @exhibitionsWithCat = @allExhibitionsWithCat.select{ |exWithCat| @selected_categories.include?(exWithCat[1])}
      @exhibitions = @exhibitionsWithCat.map{|a| a[0]}
    end

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
    params.require(:exhibition).permit(:address_street, :latitude, :longitude, :category, :title, :date_start, :date_end, :occurences, :contact_url, :address_name, :contact_twitter, :contact_phone, :description, :tags, :contact_mail, :lead_text, :contact_facebook, :cover_credit, :address_city, :price_detail, :price_type, :date_description, :address_zipcode, :external_id,:average_rating, :ratings_count)
  end

end
