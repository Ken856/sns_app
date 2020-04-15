require 'rails_helper'

RSpec.describe  User, type: :system do
  before do
    @user = User.create(name: "Hoge", email: "hoge@example.com", password: "hogehoge")
    @other_user = User.create(name: "Foo", email: "foo@example.com", password: "hogehoge")
    @user.follow @other_user
  end

  # describe "follow notification" do
  #   scenario "if other_user follow user, other_user notify user" do
  #     log_in_as @user
  #     visit notifications_path
  #     expect(page).to have_content "#{@other_user.name}さんが、あなたをフォローしました。"
  #     expect(page).to have_link "#{@other_user.name}"
  #   end
  # end
  #
  # describe "group notification" do
  #   scenario "if other_user invite user to group, other_user notify user " do
  #     created_group(@user, @other_user)
  #     click_on "Logout"
  #     log_in_as @other_user
  #     visit notifications_path
  #     expect(page).to have_content "#{@user.name}さんが、「ホゲホゲ」にあなたを招待しました。"
  #   end

    context "if other_user does not permit to participate in the group, other_user's group is not sctiveted " do
      scenario "other_user is expressed in inviting_user" do
        log_in_as(@user)
        create_group(@user, @other_user)
        visit top_user_path(@user)
        click_link "ホゲホゲグループ"
        expect(page).to have_selector '.inviting-member .profile-wrap .profile-name', text: "#{@other_user.name}"
      end

      scenario "other_user dose not get the group" do
        log_in_as(@user)
        create_group(@user, @other_user)
        click_on "Logout"
        log_in_as(@other_user)
        visit top_user_path(@other_user)
        expect(page).to_not have_content "ホゲホゲグループ"
      end

      scenario "other_user dose not get the group_chat" do
        log_in_as(@user)
        create_group(@user, @other_user)
        visit top_user_path(@user)
        click_on "Logout"
        log_in_as(@other_user)
        visit top_user_path(@other_user)
        click_on "CHAT"
        expect(page).to_not have_link "ホゲホゲグループ"
      end
    end
  end
# end
