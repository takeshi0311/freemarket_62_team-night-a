class Item < ApplicationRecord
  # belongs_to :user, foreign_key: 'user_id'
  belongs_to :category
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  belongs_to :brand
  has_many :comments
  has_one :purchase
end
