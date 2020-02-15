module RoomsHelper

  def opponent_user(user_rooms)
    user_rooms.each do |user_room|
      if user_room.user != current_user
        user_room.user
      end
    end
  end
  # link_to opponent_user(@user_rooms), opponent_user(@user_rooms)

end
