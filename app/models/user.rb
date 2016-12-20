class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :trackable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :salaries

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
