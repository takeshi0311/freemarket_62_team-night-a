class Address < ApplicationRecord
  #active_hash紐付け
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, inverse_of: :address
  
  #郵便番号正規表現
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/

  validates :postal_code,     presence: true, format: { with: VALID_POSTAL_CODE_REGEX}
  validates :prefecture_id,   presence: true
  validates :municipalitie,   presence: true
  validates :street,          presence: true
end