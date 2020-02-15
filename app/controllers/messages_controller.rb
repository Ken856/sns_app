class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create!(msg_params)
    ActionCable.server.broadcast "room_channel", message: @message.template
  end

  private
    def msg_params
      params.require(:message).permit(:content)
    end
end
