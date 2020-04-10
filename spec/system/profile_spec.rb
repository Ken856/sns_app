require 'rails_helper'

RSpec.describe  User, type: :system do
  let(:user) {User.create(name: "hoge", email: "hoge@example.com", password: "hogehoge")}

  describe "my profile" do
    scenario "correct_my_profile" do
      log_in_as user
      visit top_user_path(user)
      click_on "#{user.name}"
      expect(page).to have_content "#{user.name}"
    end
  end

  describe "friend's profile" do
    let(:friend){User.create(name: "foo", email: "foo@example.com", password: "hogehoge")}
    scenario "correct_friends_profile" do
      user.follow friend
      log_in_as user
      visit top_user_path(user)
      click_on "#{friend.name}"
      expect(page).to have_button "解除する"
      expect(page).to have_button "TALK"
      click_button "TALK"
      visit user_path(friend)
      expect(page).to have_link "TALK"
    end



  end
end
