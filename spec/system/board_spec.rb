require 'rails_helper'

RSpec.describe  Board, type: :system do
  before do
    @user = User.create(name: "Hoge", email: "hoge@example.com", password: "hogehoge")
    @other_user = User.create(name: "Foo", email: "foo@example.com", password: "hogehoge")
    @board = @user.boards.create(title: "hello, world")
  end

  scenario "create board and first post with valid information" do
    log_in_as @user
    visit top_user_path(@user)
    click_on "Board"
    click_on "新しいスレッドを作る"
    fill_in "Title", with: "ホゲホゲ"
    click_on "登録する"
    expect(page).to have_content "スレを作りました"
    fill_in "Body", with: "これは、スレ主のコメントです。"
    click_on "登録する"
    expect(page).to have_content "コメントしました。"
    expect(page).to have_content "これは、スレ主のコメントです。"
  end

  scenario "other_user post with valid information" do
    log_in_as @other_user
    visit top_user_path(@other_user)
    click_on "Board"
    click_link "#{@board.title}"
    fill_in "Body", with: "これは、スレ主ではないコメントです。"
    click_on "登録する"
    expect(page).to have_content "コメントしました"
    expect(page).to have_content "これは、スレ主ではないコメントです。"
  end
end
