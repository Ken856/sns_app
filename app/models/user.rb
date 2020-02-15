class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :active_relationships,
            class_name: "Relationship",
            foreign_key: "follower_id",
            dependent: :destroy
  has_many :passive_relationships,
            class_name:  "Relationship",
            foreign_key: "followed_id",
            dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :boards
  has_many :posts
  attr_accessor :remember_token
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # def talking
  #   duplicate_id = "SELECT room_id FROM user_rooms GROUP BY room_id HAVING  COUNT(*) > 1"
  #   user_rooms.where("user_id = :user_id AND room_id IN (#{duplicate_id})", user_id: self.id)
  # end

  def personal_chat_room(other_user)
    user_rooms_intersect(other_user).first
  end

  private
    def user_rooms_intersect(other_user)
      my_talking = self.user_rooms.all.pluck(:room_id)
      your_talking = other_user.user_rooms.all.pluck(:room_id)
      my_talking & your_talking
    end

  def can_access?(room)
    if self.following?
      true
    else
      false
    end
  end

end
