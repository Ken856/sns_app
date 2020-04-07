class Group < ApplicationRecord
  has_one_attached :group_image
  has_many :user_groups
  has_many :users, through: :user_groups
  belongs_to :room
  validates :group_name, presence: true, length: {maximum: 30}
end
