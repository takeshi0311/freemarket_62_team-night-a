FactoryBot.define do
  factory :item do
    name {"a"}
    description {"a"}
    size {"1"}
    status {"1"}
    shipping_charges {"1"}
    shipping_method {"1"}
    region {"1"}
    price {"1"}
    shopping_date {"1"}
    user
    category 
    brand 
  end
end