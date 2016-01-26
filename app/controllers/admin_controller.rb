class AdminController < ApplicationController
   before_filter :verify_admin

  def verify_admin
    :authenticate_user!
    redirect_to store_url unless has_role?(current_user, ':admin')
  end

  def index
  	@total_orders = Order.count
  end

end
