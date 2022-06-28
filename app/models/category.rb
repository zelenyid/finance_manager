class Category < ApplicationRecord
  enum category_type: {
    expense: 0,
    income: 1
  }, _prefix: true

  has_many :categories_users, dependent: :destroy
  has_many :users, through: :categories_users
  has_many :records, dependent: :nullify
end
