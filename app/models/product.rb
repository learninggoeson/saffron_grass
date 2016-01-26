class Product < ActiveRecord::Base
	validates :name, :description, :size, :color, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
 	validates :name, :uniqueness => true

 	has_many :product_images
    accepts_nested_attributes_for :product_images, :allow_destroy => true
	default_scope :order => 'name'

	has_many :line_items
	has_many :orders, :through => :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	
	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors.add(:base, 'Line Items present' )
			return false
		end
	end


end
