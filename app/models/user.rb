class User < ApplicationRecord
  extend Search
  has_one_attached :avatar
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms

  has_many :active_relationships,class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships,class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :boards
  has_many :posts
  has_many :notifier_information, class_name: "Notification", foreign_key: 'notifier_id', dependent: :destroy
  has_many :notified_information, class_name: 'Notification', foreign_key: 'notified_id', dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true, confirmation: true
  validates :introduction, length: {maximum: 250}
  attr_accessor :remember_token

  def is_activated_by?(group)
   user_group(group).activated?
  end

  def leave_group(group)
    current_user.user_group(group).destroy
  end

  def user_group(group)
    user_groups.find_by(group_id: group)
  end

  def remember
    self.remember_token = Token.new_token
    update_attribute(:remember_digest, Token.digest(remember_token))
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

  def naming
    name
  end

  def picture
    avatar
  end

  def default_picture
    "default_user.png"
  end

end
