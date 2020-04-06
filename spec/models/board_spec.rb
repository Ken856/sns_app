require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "board's validation test" do
    let(:user){FactoryBot.create(:user)}
    let!(:board){FactoryBot.build(:board, user_id: user.id)}

    it "is valid board" do
      expect(board).to be_valid
    end

    it "is invalid board without title" do
      board.title = ""
      board.valid?
      expect(board.errors[:title]).to include "を入力してください"
    end

    it "is invalid board with too long title" do
      board.title = "a" * 251
      board.valid?
      expect(board.errors[:title]).to include "は250文字以内で入力してください"
    end
  end

end
