class FixUsersColumnName < ActiveRecord::Migration
  def up
  	rename_column :users, :password, :hashed_password
  	rename_column :users, :password_salt, :salt
  end

  def down
  	
  end
end
