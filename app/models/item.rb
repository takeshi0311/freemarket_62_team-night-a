class Item < ApplicationRecord
belongs_to :user
belongs_to :category
belongs_to :brand
has_many :comments #commentsテーブルとのアソシエーション
has_many :images
has_one :purchase
end
