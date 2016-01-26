class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :sale_price, :precision => 8, :scale => 2
      t.string :sku
      t.text :description
      t.string :color
      t.string :size
      t.integer :inventory

      t.timestamps
    end
  end
  def self.down
    drop_table :products
  end

end
