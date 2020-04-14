class Notification < ApplicationRecord
  belongs_to :notifier, class_name: 'User'
  belongs_to :notified, class_name: 'User'
  belongs_to :group, optional: true
end
