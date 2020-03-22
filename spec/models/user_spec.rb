require 'rails_helper'

describe User do
    # ニックネームが20文字以上では登録できない
  it "nickname cannot be longer than 20 characters" do
    user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa")
    user.valid?
    expect(user.errors[:nickname][0]).to include("is too long")
  end
  
    # emailが重複していたら無効"
  it "Invalid if duplicate emails" do
    user = create(:user)
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("has already been taken")
  end

    # 全て入力してあれば登録できる
  it "once you have entered all, you can register" do
    user = build(:user)
    expect(user).to be_valid
  end

    # パスワードと確認が一致していないと登録できない
  it "Unable to register if password and confirmation do not match" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

    # nicknameが空でないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailが空でないこと
    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # passwordが空でないこと
    it "is invalid without an password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # password_confirmationが空でないこと
    it "is invalid without an password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    # family_nameが空でないこと
    it "is invalid without an family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    # last_nameが空でないこと
    it "is invalid without an last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    # frigana_family_nameが空でないこと
    it "is invalid without an frigana_family_name" do
      user = build(:user, frigana_family_name: "")
      user.valid?
      expect(user.errors[:frigana_family_name]).to include("can't be blank")
    end

    # frigana_last_nameが空でないこと
    it "is invalid without an frigana_last_name" do
      user = build(:user, frigana_last_name: "")
      user.valid?
      expect(user.errors[:frigana_last_name]).to include("can't be blank")
    end

    # birthday_yearが空でないこと
    it "is invalid without an birthday_year" do
      user = build(:user, birthday_year: "")
      user.valid?
      expect(user.errors[:birthday_year]).to include("can't be blank")
    end

    # birthday_monthが空でないこと
    it "is invalid without an birthday_month" do
      user = build(:user, birthday_month: "")
      user.valid?
      expect(user.errors[:birthday_month]).to include("can't be blank")
    end

    # birth_day_dayが空でないこと
    it "is invalid without an birthday_day" do
      user = build(:user, birthday_day: "")
      user.valid?
      expect(user.errors[:birthday_day]).to include("can't be blank")
    end


end