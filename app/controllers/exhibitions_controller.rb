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
    #Selecting all existing Exhib
    @allExhibitions = Exhibition.all

    #looking for all categories except "Other"

    @categories = Exhibition.select('distinct category').
      where.not(category: 'Expositions -> Autre expo').
      order('category').
      pluck(:category).
      uniq.
      map { |category| category.gsub('Expositions -> ', '') }

    #Selecting categories submited by the modal, or taking them all
    if params[:categories].presence
      @selected_categories = params[:categories].presence
    else
     @selected_categories = @categories
    end


    if params[:distanceRange]
      @maxdistance = params[:distanceRange].to_i
    else
      @maxdistance = 3
    end


## Ils chargent les cartes et après ils les display. Si tu fais toutes ils ne montrent pas la distance de celle qu'ils n(avait pas préalablement)

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



    if @selected_categories
      @allExhibitionsWithCat = @exhibitions.map{|ex| [ex,ex.category.gsub('Expositions -> ', '')]}
      @exhibitionsWithCat = @allExhibitionsWithCat.select{ |exWithCat| @selected_categories.include?(exWithCat[1])}
      @exhibitions = @exhibitionsWithCat.map{|a| a[0]}
    end

    if params[:search] && params[:search][:opened] != '0'
      @exhibitions = @exhibitions.select { |ex| ex.opens_today?(Time.now) }

      @markers = @exhibitions.map do |exhibition|
      {
        lat: exhibition.latitude,
        lng: exhibition.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { exhibition: exhibition })
      }
      end

    elsif params[:search] && params[:search][:opened] = '0'
      @exhibitions = Exhibition.all

      @exhibinParis = Exhibition.all.where(latitude:(48.79..48.94), longitude:(2.21..2.48) )
       @markers = @exhibinParis.map do |exhibition|
      {
        lat: exhibition.latitude,
        lng: exhibition.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { exhibition: exhibition })
      }
      end
    else
    @markers = @exhibitions.map do |exhibition|
      {
        lat: exhibition.latitude,
        lng: exhibition.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { exhibition: exhibition })
      }
      end

    end
  end

  def update
    @exhibition_array = Exhibition.where(external_id: external_id)
  #   @exhibition = @exhibition_array[0]
  end

private

  def find_exhibition
    @exhibition = Exhibition.find(params[:id])
  end

  def exhibition_params
    params.require(:exhibition).permit(:address_street, :latitude, :longitude, :category, :title, :date_start, :date_end, :occurences, :contact_url, :address_name, :contact_twitter, :contact_phone, :description, :tags, :contact_mail, :lead_text, :contact_facebook, :cover_credit, :address_city, :price_detail, :price_type, :date_description, :address_zipcode, :external_id,:average_rating, :ratings_count)
  end

end
