class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.create_user_rooms(current_user, other_user, room)
    UserRoom.create(user_id: current_user.id, room_id: room.id)
    UserRoom.create_other_user_rooms(other_user, room)
  end

  def self.create_other_user_rooms(other_user, room)
     if other_user.kind_of?(Array)
       other_user.each {|user| UserRoom.create(user_id: user.id ,room_id: room.id)}
     else
       UserRoom.create(user_id: other_user.id, room_id: room.id)
     end
  end

end
