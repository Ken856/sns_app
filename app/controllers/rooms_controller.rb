class RoomsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:create]

  def index
    @rooms = current_user.rooms.all
  end

  def show
    @room = Room.find(params[:id])
    @user_rooms = UserRoom.where(room_id: params[:id])
    @messages = Message.includes(:user).order(:id)
    @message = current_user.messages.build
  end

  def create
      other_user = User.find(params[:user_id])
      room = Room.create!
      current_user.user_rooms.create(room_id: room.id)
      other_user.user_rooms.create(room_id: room.id)
      redirect_to room
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end


  private
    def room_params
      params.require(:room).permit(:room_name)
    end

    def correct_user
      other_user = User.find(params[:user_id])
      if other_user == current_user
        redirect_to user_path(other_user)
      end
    end

end
