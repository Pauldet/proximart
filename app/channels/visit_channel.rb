class VisitChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    visit = Visit.find(params[:id])
    stream_for chatroom

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
