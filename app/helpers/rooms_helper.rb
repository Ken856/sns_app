module RoomsHelper

  def room_title(room, user_rooms)
     if !room.group.nil?
       render_to_profile(room.group)
     else
       user_rooms.each do |user_room|
         if user_room.user != current_user
           return render_to_profile(user_room.user)
         end
       end
     end
  end

end
