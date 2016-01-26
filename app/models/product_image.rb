class ProductImage < ActiveRecord::Base
	belongs_to :product

	require 'RMagick' 
	has_attached_file :data 
end
