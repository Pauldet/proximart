class ParticipationsController < ApplicationController

  def create
    @participation = Participation.new(participation_params)
    @exhibition = Exhibition.find(params[:exhibition_id])
    @participation.exhibition_id = params[:exhibition_id]
    @participation.save
  end

  def new
    @participation = Participation.new
  end


  private

  def find_participation
    @participation = Participation.find(params[:id])
  end

  def participation_params
    params.require(:participation).permit(:date, :review_content, :rating, :interested)
  end
end
