class User < ActiveRecord::Base
	before_create :set_default_role
	# Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role

  ROLES = %w[admin customer].freeze

  def is_customer?
    self.role == 'customer'
  end

  def is_admin?
    self.role == 'admin'
  end

  private
	  def set_default_role
	    self.role ||= 'customer'
	  end
end
