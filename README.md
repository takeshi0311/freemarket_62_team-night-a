# Name（takeshi0311/freemarket_62_team-night-a）
 プログラミングスクールで5人のチームで作成したメルカリのクローンアプリになっています。
 
# Features
 メルカリクローンとなっており、ほぼ本家のメルカリと同じ機能となっています。
 
 
# Installation
下記URLにアクセスしpassを入力してください。<br>
http://www.furima62.com/<br>

ID: 62-night<br>
Pass: 2020<br>

いかのテスト用アカウントを使い、ログインしてみてください。<br>
テスト用アカウント等<br>
購入者用<br>
メールアドレス: test@test.com<br>
パスワード: test1234<br>
購入用カード情報<br>
番号：42424242424242424<br>
期限：1月/21年<br>
セキュリティコード：123<br>
出品者用<br>
メールアドレス名: test1@test.com<br>
パスワード: test1234<br>

# Usage
 
動作確認方法<br>
Chromeの最新版を利用してアクセスしてください。<br>
===============================================================<br>
テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品<br>
テストアカウントでログイン→商品選択→商品購入<br>
===============================================================<br>
確認後、ログアウト処理をお願いします。<br>

 
# Note
デプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続ください。<br>
接続先およびログイン情報については、上記の通りです。<br>
同時に複数の方がログインしている場合に、ログインできない可能性がございます。<br>
 
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
