class SubscriptionsController < ApplicationController

def create
    @visit = Visit.find(params[:visit_id])
    @current_user_id = current_user.id
    @subscription = Subscription.new(visit_id: @visit.id, user_id:@current_user_id)
    @subscription.save
    redirect_to visit_path(@visit)
  end

  def new
    @participation = Participation.new
  end

def destroy
    @visit = Visit.find(params[:visit_id])
    @current_user_id = current_user.id
    @sub = Subscription.where(user_id: @current_user.id, visit_id: @visit.id).first
    @sub.destroy
    redirect_to visit_path(@visit)
  end

  private

  # def find_participation
  #   @participation = Participation.find(params[:id])
  # end

  # def participation_params
  #   params.require(:participation).permit(:date, :review_content, :rating, :interested)
  # end
end

