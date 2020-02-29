class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

        has_many :items
        has_many :purchases
        has_many :comments
        has_one  :pay
        has_one  :address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,100}/i
  VALID_PHONE_REGEX = /(0{1}\d{9,10})/


  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}
  validates :family_name,             presence: true, length: {minimum: 1, maximum: 128}
  validates :last_name,               presence: true, length: {minimum: 1, maximum: 128}
  validates :frigana_family_name,     presence: true, length: {minimum: 1, maximum: 128}
  validates :frigana_last_name,       presence: true, length: {minimum: 1, maximum: 128}
  validates :birthday_year,           presence: true
  validates :birthday_month,          presence: true
  validates :birthday_day,            presence: true
  validates :phone_number,            presence: true, format: { with: VALID_PHONE_REGEX }
end


