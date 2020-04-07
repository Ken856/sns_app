require 'rails_helper'

RSpec.describe  User, type: :system do
  before do
    @user = User.create(name: "Hoge", email: "hoge@example.com", password: "hogehoge")
    @other_user = User.create(name: "Foo", email: "foo@example.com", password: "hogehoge")
    @user.follow @other_user
    @group = Group.create
  end

  scenario "create chat_room with friends with valid information" do
    log_in_as @user
    visit top_user_path(@user)
    click_on "Foo"
    click_on "TALK"
    expect(page).to have_selector 'h1', text: "#{@other_user.name}"
  end

  scenario "create chat_room in group with valid information" do
    log_in_as @user
    visit top_user_path(@user)
  end
end
