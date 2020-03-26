FactoryBot.define do

  factory :item do
    name                  {"ネックレス"}
    description           {"新品で綺麗です。"}
    brand                 {"シャネル"}
    status                {"新品、未使用"}
    shipping_method       {"送料込み(出品者負担)"}
    price                 {"5000"}
    region                {"東京都"}
    shopping_date         {"1~2日で発送"}
    category
    user
  end

  factory :image do
    image                 {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sky.JPG'))}
  end

  factory :category do
    name                  {"トップス"}
    ancestry              {"1"}
  end


end