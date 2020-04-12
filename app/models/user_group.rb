class UserGroup < ApplicationRecord
  # before_create :investigate
  belongs_to :user
  belongs_to :group

  # private
  #   def investigate
  #     token =
  #   end
end
