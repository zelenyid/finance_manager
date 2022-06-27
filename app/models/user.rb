class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :categories_users, dependent: :destroy
  has_many :categories, through: :categories_users
  has_many :accounts, dependent: :destroy
end
