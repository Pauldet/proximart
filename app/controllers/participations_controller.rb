class ParticipationsController < ApplicationController

  def create
    @participation = Participation.new(participation_params)
    @exhibition = Exhibition.find(params[:exhibition_id])
    @participation.exhibition_id = params[:exhibition_id]
    @participation.user = current_user
    @participation.save
    redirect_to exhibition_path(@exhibition)
  end

  def new
    @exhibition = Exhibition.find(params[:exhibition_id])
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
