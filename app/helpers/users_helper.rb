module UsersHelper
  def personal_chat_room(current_user, other_user)
    @room = user_rooms_intersect(current_user, other_user).first
  end

  def user_rooms_intersect(current_user, other_user)
    my_talking = current_user.user_rooms.all.pluck(:room_id)
    your_talking = other_user.user_rooms.all.pluck(:room_id)
    my_talking & your_talking
  end

end
