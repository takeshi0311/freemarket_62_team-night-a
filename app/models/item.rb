class Item < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name,                presence: true, length: { maximum: 40 }
  validates :description,         presence: true, length: { maximum: 1000 }
  validates :status,              presence: true
  validates :shipping_method,     presence: true
  validates :region,     presence: true
  validates :shopping_date,       presence: true
  validates :price,               presence: true, numericality: { only_integer: true, greater_than: 299, less_than: 10000000}

  # validates_associated:両方のモデルに対してバリデーションを実行する必要がある場合に使用。
  validates_associated :images


  # belongs_to :brand
  has_many :comments
  has_one :purchase

  belongs_to :user
  has_many :favorite,dependent: :destroy
  has_many :Favorite_users, through: :Favorites, source: :user
  
  def Favorite_user(user_id)
    favorites.find_by(user_id: user_id)
  end
 

end
