class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

        has_many :items
        has_many :purchases
        has_many :comments
        has_many :items, dependent: :destroy #お気に入り機能、ユーザーがデータベースから削除されてしまった場合にユーザーがした投稿も全て消えるように
        has_many :favorite, dependent: :destroy
        has_many :favorited_items, through: :favoriteds, source: :post
        has_one  :pay
        has_one  :address,inverse_of: :user
        has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"

        accepts_nested_attributes_for :address

        def already_favorited?(item)
          self.favorite.exists?(item_id: item.id)
        end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,100}/i


  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, format: { with: VALID_PASSWORD_REGEX }, on: :create
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}, on: :create
  validates :family_name,             presence: true, length: {minimum: 1, maximum: 128}
  validates :last_name,               presence: true, length: {minimum: 1, maximum: 128}
  validates :frigana_family_name,     presence: true, length: {minimum: 1, maximum: 128}
  validates :frigana_last_name,       presence: true, length: {minimum: 1, maximum: 128}
  validates :birthday_year,           presence: true
  validates :birthday_month,          presence: true
  validates :birthday_day,            presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email,
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end




