class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user)
    @room = Room.find(@group.room.id)
  end

  def new
    @room = Room.new
    @group = @room.build_group
    @followings = current_user.following.select(:id, :name)
  end

  def create
    room = Room.create
    group = room.build_group(group_params)
    if group.save
      group.user_groups.create(user_id: current_user.id)
      group.user_groups.create(user_id: params[:user_id])
      flash[:notice] = "グループを作成しました"
      redirect_to top_user_path(current_user)
    else
      render :new
    end
  end

  private
    def group_params
      params.require(:group).permit(:group_name, :group_image, user_ids: [])
    end

end
