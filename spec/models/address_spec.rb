require 'rails_helper'

describe Address do
  it "郵便番号のフォーマットが間違いの時" do
    address = create(:user)
    address = build(:address, postal_code: "aaaaaaaa")
    expect(address).to be_invalid
  end

  it "郵便番号が空ではないこと" do
    address = build(:address, postal_code: nil)
    address.valid?
    expect(address.errors[:postal_code]).to include("can't be blank")
  end

  it "都道府県が空ではないこと" do
    address = build(:address, prefecture_id: nil)
    address.valid?
    expect(address.errors[:prefecture_id]).to include("can't be blank")
  end

  it "市区町村が空ではないこと" do
    address = build(:address, municipalitie: nil)
    address.valid?
    expect(address.errors[:municipalitie]).to include("can't be blank")
  end

  it "番地が空ではないこと" do
    address = build(:address, street: nil)
    address.valid?
    expect(address.errors[:street]).to include("can't be blank")
  end
end