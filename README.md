# FURIMA DB設計

[ER図](https://gyazo.com/64f88446edfa37fc802f98a5277dd6d4)

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
|birthday|integer|null :false|
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
