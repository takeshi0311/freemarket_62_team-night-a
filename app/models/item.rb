class Item < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  #belongs_to :buyer, class_name: "User"
  belongs_to :category
  has_many :images,dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
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
