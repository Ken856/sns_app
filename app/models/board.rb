class Board < ApplicationRecord
  extend Search
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :title, presence: true, length: {maximum: 250}
  validates :user_id, presence: true
end
