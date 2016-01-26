class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end
end
