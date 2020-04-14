class Group < ApplicationRecord
  has_one_attached :group_image
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :notifications
  belongs_to :room, optional: true 
  validates :group_name, presence: true, length: {maximum: 30}

  def invite(user, activated)
    user_groups.create(user_id: user, activated: true)
  end

  def naming
    group_name
  end

  def picture
    group_image
  end

  def default_picture
    "default_group.png"
  end

end
