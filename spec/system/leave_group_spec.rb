require 'rails_helper'

RSpec.describe  Group, type: :system do
  let(:user){FactoryBot.create(:user, email: "hoge@example.com")}
  let(:other_user){FactoryBot.create(:other_user)}
  
  before do 
    user.follow other_user
  end

  describe "leave the group test" do
    scenario "leave the group from group profile" do
      log_in_as user
      create_group(user, other_user)
      visit top_user_path(user)
      click_on "ホゲホゲグループ"
      expect(page).to have_link "退会する"
      click_link "退会する"
      visit top_user_path(user)
      expect(page).to_not have_content "ホゲホゲグループ"
    end

    scenario "reject to perticipate in the group from notification page" do
      log_in_as user
      create_group(user, other_user)
      visit top_user_path(user)
      click_on "Logout"
      expect(page).to have_content "WELCOME"
      log_in_as(other_user)
      click_on "通知"
      click_on "拒否する"
      visit top_user_path(other_user)
      expect(page).to_not have_content "ホゲホゲグループ"
    end
  end
end
