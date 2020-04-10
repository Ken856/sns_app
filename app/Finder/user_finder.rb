module UserFinder
  extend ActiveSupport::Concern

 def find_personal_chat_room(other_user)
    user_rooms_intersect(other_user)
 end

 private
   def user_rooms_intersect(other_user)
     my_talking = self.user_rooms.all.pluck(:room_id)
     your_talking = other_user.user_rooms.all.pluck(:room_id)
     intersection = my_talking & your_talking
     intersection.each {|i| return i}
   end
end
