class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable
end
