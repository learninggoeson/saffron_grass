require 'digest/sha2'
require 'role_model'

class User < ActiveRecord::Base
	validates :name, :presence => true
	attr_accessible :name
	validates :password, :confirmation => true
	attr_accessor :password_confirmation
	attr_reader	:password
	validate	:password_must_be_present
	# after_destroy :ensure_an_admin_remains
	before_save :setup_role

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	    :recoverable, :rememberable, :trackable, :validatable

	include RoleModel
	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation

	# optionally set the integer attribute to store the roles in,
	# :roles_mask is the default
	roles_attribute :roles_mask

	# declare the valid roles -- do not change the order if you add more
	# roles later, always append them at the end!
	roles :admin, :customer, :guest

# *****************************************************
# ROLE MASK USAGE****************
#
# Test drive (check the RDoc or source for additional finesse)
#

# >> u = User.new
# => #<User ...>

# # role assignment
# >> u.roles = [:admin]  # ['admin'] works as well
# => [:admin]

# # adding roles (remove via delete or re-assign)
# >> u.roles << :manager
# => [:admin, :manager]

# # querying roles...

# # get all valid roles that have been declared
# >> User.valid_roles
# => [:admin, :manager, :author]

# # ... retrieve all assigned roles
# >> u.roles # also: u.role_symbols for DeclarativeAuthorization compatibility
# => [:admin, :manager]

# # ... check for individual roles
# >> u.has_role? :author  # has_role? is also aliased to is?
# => false

# # ... check for multiple roles
# >> u.has_any_role? :author, :manager  # has_any_role? is also aliased to is_any_of?
# => true

# >> u.has_all_roles? :author, :manager  # has_all_roles? is also aliased to is?
# => false

# # see the internal bitmask representation (3 = 0b0011)
# >> u.roles_mask
# => 3

# # see the role mask for a certain role(s)
# >> User.mask_for :admin, :author
# => 5
# ****************************************************************************

	# def ensure_an_admin_remains
	# 	if User.count.zero?
	# 		raise "Can't delete last user"
	# 	end
	# end

	# Default role is "Customer"
	def setup_role 
		if self.roles.empty?     
		  self.roles = [:customer]
		end
	end

	# check role of user
	def role?(role)
	    return self.has_role? role
	end

	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end

	def password=(password)
		@password = password
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end
	def User.authenticate(name, password)
		if user = find_by_name(name)
			if user.hashed_password == encrypt_password(password, user.salt)
				user
			end
		end
	end


	private
	
		def password_must_be_present
			errors.add(:password, "Missing password" ) unless hashed_password.present?
		end

		def generate_salt
			self.salt= self.object_id.to_s + rand.to_s
		end

end
