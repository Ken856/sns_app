require 'rails_helper'

RSpec.describe  User, type: :system do
  describe "login" do
    before do
      user = create(:user, email: "hoge@example.com")
    end
      it "login with valid information" do
        visit login_path
        fill_in 'メールアドレス', with: 'hoge@example.com'
        fill_in 'パスワード', with: 'hogehoge'
        fill_in 'password_confirmation', with: 'hogehoge'
        click_button 'LOGIN'
        expect(page).to have_link 'Logout'
      end

      it "login with invalid information" do
        visit login_path
        fill_in 'メールアドレス', with: 'hoge@invalid'
        fill_in 'パスワード', with: 'foo'
        #fill_in 'パスワードの確認', with: 'foo'
        click_button 'LOGIN'
        expect(page).to have_content ("Invalid email/password combination")
        expect(page).to_not have_link 'Logout'
      end
  end
end
