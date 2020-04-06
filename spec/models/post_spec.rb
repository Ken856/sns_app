require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user){FactoryBot.create(:user)}
  let(:board){FactoryBot.create(:board, user_id: user.id)}
  let!(:post){FactoryBot.build(:post, user_id: user.id, board_id: board.id)}

  it "is valid post" do
    expect(post).to be_valid
  end

  it "is invalid post without body" do
    post.body = ""
    post.valid?
    expect(post.errors[:body]).to include("を入力してください")
  end

  it "is invalid post with too long body" do
    post.body = "a" * 501
    post.valid?
    expect(post.errors[:body]).to include("は500文字以内で入力してください")
  end
end
