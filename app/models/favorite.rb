class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :item, dependent: :destroy
  validates_uniqueness_of :item_id, scope: :user_id
end
