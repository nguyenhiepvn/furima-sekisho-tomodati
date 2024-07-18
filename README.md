# Database Design

## users テーブル

| Column             | Type    | Options                   |
|--------------------|---------|---------------------------|
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| password           | string  | null: false               |
| last-name          | string  | null: false               |
| first-name         | string  | null: false               |
| last-name-kana     | string  | null: false               |
| first-name-kana    | string  | null: false               |
| birth-date         | date    | null: false               |

### Association

- has_many :items
- has_many :orders
- has_many :comments

## items テーブル

| Column                   | Type       | Options                        |
|--------------------------|------------|--------------------------------|
| item-name                | string     | null: false                    |
| item-info                | text       | null: false                    |
| item-category            | integer    | null: false                    |
| item-sales-status        | integer    | null: false                    |
| item-shipping-fee-status | integer    | null: false                    |
| item-prefecture          | integer    | null: false                    |
| item-scheduled-delivery  | integer    | null: false                    |
| item-price               | integer    | null: false                    |
| user                     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## orders テーブル

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| postal-code   | string     | null: false                    |
| prefecture    | integer    | null: false                    |
| city          | string     | null: false                    |
| addresses     | string     | null: false                    |
| building      | string     |                                |
| phone-number  | string     | null: false                    |
| user-id       | references | null: false, foreign_key: true |
| item-id       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type       | Options                        |
|----------------|------------|--------------------------------|
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order

## comments テーブル

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| content | text       | null: false                    |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
