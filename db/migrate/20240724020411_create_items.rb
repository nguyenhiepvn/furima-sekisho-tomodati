class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name,                 null: false
      t.string :description,          null: false
      t.string :category_id,          null: false
      t.string :condition_id,         null: false
      t.string :postage_payer_id,     null: false
      t.string :prefecture_id,        null: false
      t.string :preparation_day_id,   null: false
      t.string :price,                null: false
      t.references :user,             null: false

      t.timestamps
    end
  end
end