require 'rails_helper'

describe Item do

  # 「画像」がないと登録できない
  it "is invalid without a image" do
    item = build(:image, image: "")
    item.valid?
    expect(item.errors[:image]).to include("can't be blank")
  end

  # 「商品名」がないと登録できない
  it "is invalid without a name" do
    item = build(:item, name: "")
    item.valid?
    expect(item.errors[:name]).to include("can't be blank")
  end

  # 「商品名」が40文字以下でないと登録できない
  it "of name is limited to 40 characters" do
    item = build(:item, name: "ア" * 41)
    item.valid?
    expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
  end

  # 「商品説明」がないと登録できない
  it "is invalid without a description" do
    item = build(:item, description: "")
    item.valid?
    expect(item.errors[:description]).to include("can't be blank")
  end

  # 「商品説明」が1000文字以下でないと登録できない
  it "of description is limited to 1000 characters" do
    item = build(:item, description: "ア" * 1001)
    item.valid?
    expect(item.errors[:description]).to include("is too long (maximum is 1000 characters)")
  end

  # 「カテゴリー」がないと登録できない
  it 'is invalid without category_id' do
    item = build(:item, category_id: "")
    item.valid?
    expect(item.errors[:category]).to include("must exist")
  end

  # 「ブランド」がなくても登録できる
  it 'is valid without brand' do
    item = build(:item, brand: "")
    expect(item).to be_valid
  end

  # 「商品の状態」がないと登録できない
  it "is invalid without a status" do
    item = build(:item, status: "")
    item.valid?
    expect(item.errors[:status]).to include("can't be blank")
  end

  # 「配送料の負担」がないと登録できない
  it "is invalid without a shipping_method" do
    item = build(:item, shipping_method: "")
    item.valid?
    expect(item.errors[:shipping_method]).to include("can't be blank")
  end

  # 「発送までの日数」がないと登録できない
  it "is invalid without a shopping_date" do
    item = build(:item, shopping_date: "")
    item.valid?
    expect(item.errors[:shopping_date]).to include("can't be blank")
  end

  # 「価格」がないと登録できない
  it "is invalid without a price" do
    item = build(:item, price: "")
    item.valid?
    expect(item.errors[:price]).to include("can't be blank")
  end

  # 「価格」が300円以上でないと登録できない
  it "of price is minimum 300 yen" do
    item = build(:item, price: 299)
    item.valid?
    expect(item.errors[:price]).to include("must be greater than 299")
  end

  # 「価格」が999999円以下でないと登録できない
  it "of price is maximum 9999999 yen" do
    item = build(:item, price: 10000000)
    item.valid?
    expect(item.errors[:price]).to include("must be less than 10000000")
  end

end