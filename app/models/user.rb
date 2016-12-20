class User < ApplicationRecord
  attr_accessor :login
  has_many :salaries
  validates :username, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :trackable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
