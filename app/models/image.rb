class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true, dependent: :destroy

  validates :image,        presence: true
end
