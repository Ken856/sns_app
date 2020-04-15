require 'rails_helper'

RSpec.describe  Group, type: :system do
  before do
    @user = User.create(name: "Hoge", email: "hoge@example.com", password: "hogehoge")
    @other_user = User.create(name: "Foo", email: "foo@example.com", password: "hogehoge")
    @user.follow @other_user
  end

  describe "leave the group test" do
    scenario "leave the group from group profile" do
      log_in_as(@user)
      create_group(@user, @other_user)
      visit top_user_path(@user)
      click_on "ホゲホゲグループ"
      expect(page).to have_link "退会する"
      click_on "退会する"
      visit top_user_path(@user)
      expect(page).to_not have_content "ホゲホゲグループ"
    end

    scenario "reject to perticipate in the group from notification page" do
      log_in_as(@user)
      create_group(@user, @other_user)
      visit top_user_path(@user)
      click_on "Logout"
      log_in_as(@other_user)
      visit notifications_path
      click_on "拒否する"
      visit top_user_path(@@other_user)
      expect(page).to_not have_content "ホゲホゲグループ"
    end
  end
end
