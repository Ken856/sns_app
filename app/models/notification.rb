class Notification < ApplicationRecord
  belongs_to :notifier, class_name: 'User', dependent: :destroy
  belongs_to :notified, class_name: 'User', dependent: :destroy
  belongs_to :group, optional: true, dependent: :destroy
end
