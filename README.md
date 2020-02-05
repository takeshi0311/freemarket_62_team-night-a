# FURIMA DB設計

## users
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|last_name|string|null :false|
|j-family_name|string|null :false|
|j-family_name|string|null :false|
|birthday|integer|null :false|
|phone_number|integer|null :false|
|profile|text||

### Association
- has_many exhibitions
- has_many purchases
- has_many comments
- has_one pay
- has_one adress

## exhibitions
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|size|string||
|stats|string|null: false|
|shipping_charges|string|null: false|
|shipping_method|string|null: false|
|region|string|null: false|
|price|integer|nill: false|
|shopping_date|string|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user
- belongs_to category
- belongs_to bramd
- has_many comments
- has_many images
- has_one purchase

## comments
|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|exhibition_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user
- belongs_to exhibition

## images
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|exhibition_id|integer|null: false, foreign_key: true|

### Association
- belongs_to exhibition

## adresses
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefectures|string|null: false|
|municipalities|sturing|null: false|
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
|security-code|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user

## purchases
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|exhibition_id|integer|null: false, foreign_key: true|

### Association
- belongs_to user
- belongs_to exhibition

## categorys
|Column|Type|Options|
|------|----|-------|
|type|string|null: false|
|exhibition_id|integer|null: false, foreign_key: true|

### Association
- has_many exhibitions
- has_ancestry

## brands
|Column|Type|Options|
|------|----|-------|
|type|string|null: false|
|exhibition_id|integer|null: false, foreign_key: true|

### Association
- has_many exhibitions