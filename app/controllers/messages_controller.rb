class MessagesController < ApplicationController
  def create
      @visit = Visit.find(params[:visit_id])
      @message = Message.new(message_params)
      @message.visit = @visit
      @message.user = current_user
      @message.save!
      if @message.save
        message = @message
        VisitChannel.broadcast_to(
          @visit,
          render_to_string(partial: "messages/message", locals: { message: message })
          )
        redirect_to visit_path(@visit, anchor: 'messcre')
        # redirect_to visit_path(@visit)
      else
      redirect_to visit_path(@visit, anchor: 'messcre') #render "chatrooms/show"
      end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
