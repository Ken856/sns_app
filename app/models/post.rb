class Post < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :body, presence: true, length: {maximum: 500}
  validates :user_id, presence: true
  validates :board_id, presence: true
end
