class User < ApplicationRecord
  has_many :history_translations

  acts_as_authentic
end
