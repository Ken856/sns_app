class Notify
  private_class_method :new

  def self.call(notifier, notified, action, group: nil)
    new(notifier, notified, action, group).send(:call)
  end

  private
    attr_accessor :notifier, :notified, :action, :group

    def initialize(notifier, notified, action, group)
      @notifier = notifier
      @notified = notified
      @action = action
      @group = group
    end

    def call
      temp = Notification.where("notifier_id = ? and notified_id = ? and action = ? and group_id = ?", notifier.id, notified.id, action, group&.id)
      if temp.blank?
        create_notification
      end
    end

    def create_notification
      notification = Notification.new(
        notifier_id: notifier.id,
        notified_id: notified.id,
        action: action,
        group_id: group&.id
      )
      if notification.valid?
        notification.save
      else 
        raise("baka")
      end
    end
end


#ユーザがユーザに通知をするクラス
#グループなどは、通知の本質ではなく、付加情報なのでオプションハッシュを取る。
