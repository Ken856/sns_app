class GroupsController < ApplicationController
  before_action :logged_in_user

  def show
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user)
    @room = Room.find(@group.room.id)
  end

  def new
    @group = Group.new
    @followings = current_user.following.select(:id, :name)
  end

  def create
    group = Group.new(group_params)
    if group.save
      room = group.create_room
      group.user_groups.create(user_id: current_user.id, activated: true)
      group.users.each do |user|
        Notify.call(current_user, user, "group", group: group) if user != current_user
      end
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
