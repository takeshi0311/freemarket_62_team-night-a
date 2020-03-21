FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {"test@gmail.com"}
    password              {"1234abcd"}
    password_confirmation {"1234abcd"}
    family_name           {"山田"}
    last_name             {"彩"}
    frigana_family_name   {"ヤマダ"}
    frigana_last_name     {"アヤ"}
    birthday_year         {"1999"}
    birthday_month        {"1"}
    birthday_day          {"1"} 
    phone_number          {"09012345678"}
  end
  
end