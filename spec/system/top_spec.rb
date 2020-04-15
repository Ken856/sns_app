require 'rails_helper'

RSpec.describe  User, type: :system do
  before do
    @user = User.create(name: "Hoge", email: "hoge@example.com", password: "hogehoge")
    @other_user = User.create(name: "Foo", email: "foo@example.com", password: "hogehoge")
    @user.follow @other_user
  end

  scenario "correct top interface test" do
    log_in_as @user
    visit top_user_path(@user)
    expect(page).to have_content "Hoge"
    expect(page).to have_content "Foo"
  end
end
