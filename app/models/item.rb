class Item < ApplicationRecord
  # belongs_to :user, foreign_key: 'user_id'
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
end
