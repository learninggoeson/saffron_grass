class ApplicationController < ActionController::Base
  	# before_filter :authorize
  	# before_filter :authenticate_user!
  	# skip_before_filter :verify_authenticity_token
  	protect_from_forgery

	def has_role?(current_user, role)
		return current_user.has_role? role
	end

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to store_url, :alert => exception.message
	end

	private
		def current_cart
			Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
			cart = Cart.create
			session[:cart_id] = cart.id
			cart
		end

	# protected
	# 	def authorize
	# 		unless User.find_by_id(session[:user_id])
	# 			redirect_to login_url, :notice => "Please log in"
	# 		end
	# 	end

end
