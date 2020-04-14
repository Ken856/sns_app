class InviteFriend
  def self.call(user, group_room)
    new(user, group_room).send(:call)
  end

  private
    attr_accessor :user, :group_room, :token

    def initialize(user, group)
      @user = user
      @group = group_room
      @token = Token.new_token
    end

    def call
      create_invited_digest
      notify_with_token
    end

    def create_invited_digest
      user_room.invited_digest = Token.digest(token) )
    end

    def notify_with_token
      notify(user, token)
    end
end
