# FURIMA DB設計
https://www.lucidchart.com/invitations/accept/f31cae39-ac94-4141-97d5-5e0735d0deca

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
|profile|text||

### Association
- has_many items
- has_many purchases
- has_many comments
- has_one pay
- has_one address

## items
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|size|string||
|status|integer|null: false, enum|
|shipping_charges|string|null: false|
|shipping_method|string|null: false|
|region|string|null: false|
|price|integer|nill: false|
|shopping_date|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user
- belongs_to category
- belongs_to brand
- has_many comments
- has_many images
- has_one purchase

## comments
|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
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
|prefecture|string|null: false|
|municipalitie|sturing|null: false|
|building|string||
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user

## pays
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|month|integer|null: false|
|year|integer|null: false|
|security_code|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user

## purchases
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user
- belongs_to item

## categorys
|Column|Type|Options|
|------|----|-------|
|type|string|null: false|

### Association
- has_many items
- has_ancestry

## brands
|Column|Type|Options|
|------|----|-------|
|type|string|null: false|

### Association
- has_many items