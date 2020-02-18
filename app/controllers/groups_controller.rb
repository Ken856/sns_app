class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
    @members = @group.users.all
  end

  def new
    @group = Group.new
    @followings = current_user.following.select(:id, :name)
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.user_groups.create(user_id: current_user.id)
      @group.user_groups.create(user_id: params[:user_id])
      flash[:notice] = "グループを作成しました"
      redirect_to top_user_path(current_user)
    else
      render :new
    end
  end

  private
    def group_params
      params.require(:group).permit(:group_name, user_ids: [])
    end

end
