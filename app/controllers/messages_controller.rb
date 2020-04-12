class MessagesController < ApplicationController

  def create
    @message = Message.create(msg_params)
    ActionCable.server.broadcast "room_channel_#{@message.room_id}", room_id: @message.room_id ,message: @message.template
  end

  private
    def msg_params
      params.require(:message).permit(:content, :user_id, :room_id)
    end
end
