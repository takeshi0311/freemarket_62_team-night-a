# Name（takeshi0311/freemarket_62_team-night-a）
 プログラミングスクールで5人のチームで作成したメルカリのクローンアプリになっています。
 
# Features
 メルカリクローンとなっており、ほぼ本家のメルカリと同じ機能となっています。
 
 
# Installation
下記URLにアクセスしpassを入力してください。
http://www.furima62.com/

ID: 62-night
Pass: 2020

いかのテスト用アカウントを使い、ログインしてみてください。
テスト用アカウント等
購入者用
メールアドレス: test@test.com
パスワード: test1234
購入用カード情報
番号：42424242424242424
期限：1月/21年
セキュリティコード：123
出品者用
メールアドレス名: test1@test.com
パスワード: test1234

# Usage
 
動作確認方法
Chromeの最新版を利用してアクセスしてください。
===============================================================
テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
テストアカウントでログイン→商品選択→商品購入
===============================================================
確認後、ログアウト処理をお願いします。

 
# Note
デプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続ください。
接続先およびログイン情報については、上記の通りです。
同時に複数の方がログインしている場合に、ログインできない可能性がございます。
 
# Author
* 作成者：スズキタケシ

* E-mail：takeshi.c.suzuki@gmail.com

# FURIMA DB設計

[ER図](https://gyazo.com/065d52bdfbbc98b534fcd4d104dbc1fa)

## users
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|last_name|string|null :false|
|frigana_family_name|string|null :false|
|frigana_last_name|string|null :false|
|phone_number|integer|null :false|
|birthday_year|integer|null :false|
|birthday_month|integer|null :false|
|birthday_day|integer|null :false|
### Association
- has_many items
- has_many comments
- has_one pay
- has_one address
- has_many favorite
## items
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|status|integer|null: false, enum|
|shipping_method|string|null: false|
|brand|string||
|region|string|null: false|
|price|integer|nill: false|
|shopping_date|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|buyer_id|integer||
|Favorites_count|integer||
### Association
- belongs_to user
- belongs_to category
- has_many comments
- has_many images
## comments
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to user
- belongs_to item
## images
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to item
## addresses
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture_id|string|null: false|
|municipalitie|string|null: false|
|street|string|null: false|
|building|string||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to user
## pays
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to user
## categories
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many items
- has_ancestry
## favorites
|Column|Type|Options|
|------|----|-------|
|item_id|integer||
|user_id|integer||
### Association
- has_many items
- has_many user
## sns_credentials
|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user_id|integer||
### Association
- has_many user
