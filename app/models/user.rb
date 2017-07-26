class User < ApplicationRecord
  has_many :history_translations

  validates :email, presence: true
  validates :password, confirmation: true

  acts_as_authentic
end
