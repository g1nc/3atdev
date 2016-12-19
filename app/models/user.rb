class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :trackable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
end
