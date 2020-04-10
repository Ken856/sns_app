require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid user" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "invalid user name" do
    it "is invalid user without name " do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "is invalid user with too long name" do
      user = FactoryBot.build(:user, name: "a" * 51)
      user.valid?
      expect(user.errors[:name]).to include("は50文字以内で入力してください")
    end
  end

  describe "invalid user email" do
    it "is invalid user without email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid user with too long email" do
      user = FactoryBot.build(:user, email: "a" * 244 + "@example.com" )
      user.valid?
      expect(user.errors[:email]).to include("は255文字以内で入力してください")
     end

     it "is valid with correct email adress format" do
       valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
       valid_addresses.each do |valid_address|
         user = FactoryBot.build(:user, email: valid_address)
         user.valid?
         expect(user).to be_valid
       end
     end

    it "is invalid with bad email address format" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user = FactoryBot.build(:user, email: invalid_address)
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
     end

     it "is invalid without uniqueness" do
      FactoryBot.create(:user, email: "hoge@example.com")
      user = FactoryBot.build(:user, email: "HOGE@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
     end
   end

   describe "invalid password" do
     it "is invalid user without password" do
       user = FactoryBot.build(:user, password: nil)
       user.valid?
       expect(user.errors[:password]).to include("を入力してください")
     end

     it "is invalid user with too short password" do
        user = FactoryBot.build(:user, password: "foge")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

    describe "invalid introduction" do
      it "is invalid with too long introduction" do
        user = FactoryBot.build(:user, introduction: "a" * 251)
        user.valid?
        expect(user.errors[:introduction]).to include("は250文字以内で入力してください")
      end
    end

end
