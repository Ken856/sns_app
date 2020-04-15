class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notified_information.all
    @unchecked_notifications = @notifications.select {|notification| notification.checked == false}
    # @notifications.where(checked: false).each do |notification|
    #   notification.update_attributes(checked: true)
    # end
  end

  def update
    notification = Notification.find(params[:id])
    notification.update_column(:checked, true )
    redirect_to notifications_path
  end
end
