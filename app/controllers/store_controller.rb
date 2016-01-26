class StoreController < ApplicationController
  # skip_before_filter :authorize
before_filter :authenticate_user!, except: [:index] 
  def index
  	@products = Product.all
  	@cart = current_cart
  end

end
