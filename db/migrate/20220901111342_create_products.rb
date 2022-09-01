class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.string :serial_no
      t.integer :price
      t.bigint :user_id
      t.timestamps
    end
  end
end
