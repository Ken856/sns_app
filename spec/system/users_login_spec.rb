require 'rails_helper'

RSpec.describe  User, type: :system do
  describe "login" do
    before do
      user = create(:user, email: "hoge@example.com")
    end

    scenario "login with valid information" do
      visit login_path
      fill_in 'Email', with: 'hoge@example.com'
      fill_in 'Password', with: 'hogehoge'
      # fill_in 'Password confirmation', with: 'hogehoge'
      click_button 'LOGIN'
      expect(page).to have_link 'Logout'
    end

    scenario "login with invalid information" do
      visit login_path
      fill_in 'Email', with: 'hoge@invalid'
      fill_in 'Password', with: 'foo'
      # fill_in 'Password confirmation', with: 'bar'
      click_button 'LOGIN'
      expect(page).to have_content ("Invalid email/password combination")
      expect(page).to_not have_link 'Logout'
    end

    scenario "login with cookies" do
      visit login_path
      fill_in 'Email', with: 'hoge@example.com'
      fill_in 'Password', with: 'hogehoge'
      check "Remember me on this computer"
      click_button 'LOGIN'
      expect(page).to have_link "Logout"
    end
  end
end
