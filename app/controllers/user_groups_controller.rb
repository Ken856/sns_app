class UserGroupsController < ApplicationController

  def update
    user_group = UserGroup.find(params[:id])
    if user_group.update_column(:activated, true)
      user_group.group.notifications.find_by(notified_id: current_user).update_column(:checked, true)
      redirect_to user_group.group.room
    end
  end

  def destroy
    user_group = UserGroup.find(params[:id])
    user_group.destroy
    user_group.group.notifications.find_by(notified_id: current_user.id).update_column(:checked, true)
    flash[:notice] = "退出しました。"
    redirect_to top_user_path(current_user)
  end
end
