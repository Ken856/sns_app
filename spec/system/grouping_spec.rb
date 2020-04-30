require 'rails_helper'

RSpec.describe  Group, type: :system do
  let(:user){FactoryBot.create(:user)}
  let(:other_user){FactoryBot.create(:other_user)}
  
  before do
    user.follow other_user
  end

  scenario 'create group with valid information' do
    log_in_as user
    visit top_user_path(user)
    click_on "新しいグループを作る"
    visit new_group_path
    fill_in 'Group name', with: "ホゲホゲ"
    check "#{other_user.name}"
    click_on "登録する"
    expect(page).to have_content 'グループを作成しました'
    click_on "ホゲホゲ"
    click_on "TALK"
    expect(page).to have_content "ホゲホゲ"
  end
end
