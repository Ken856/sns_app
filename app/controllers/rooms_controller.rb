class RoomsController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_user, only: [:create]

  def index
    @rooms = current_user.rooms.all
    @groups = current_user.groups.all
  end

  def show
    @room = Room.find(params[:id])
    @user_rooms = UserRoom.where(room_id: params[:id])
    #@messages = Message.includes(:user, :room).order(:id)
    @messages = @room.messages.all
    @message = Message.new
    gon.current_user_id = current_user.id
  end

  def create
      other_user = User.find(params[:user_id])
      room = Room.create(room_params)
      UserRoom.create_user_rooms(current_user, other_user, room)
      redirect_to room
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end


  private
    def room_params
      params.permit(:room_name)
    end

    # def correct_user
    #   other_user = User.find(params[:user_id])
    #   if other_user == current_user
    #     redirect_to user_path(other_user)
    #   end
    # end

end
