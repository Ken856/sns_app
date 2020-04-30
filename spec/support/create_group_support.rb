module CreateGroupSupport

  def create_group(user, other_user)
    visit top_user_path(user)
    click_on "新しいグループを作る"
    visit new_group_path
    fill_in 'Group name', with: "ホゲホゲグループ"
    check other_user.name
    click_on "登録する"
  end
  RSpec.configure do |config|
    config.include CreateGroupSupport
  end
end