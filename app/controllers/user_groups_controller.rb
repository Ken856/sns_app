class UserGroupsController < ApplicationController

  def update
    user_room = UserGroup.find(params[:id])
    if user_room.update_attribute(:activated, true)
    redirect_to user_room.group.room
    end
  end
end
