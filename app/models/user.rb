class User < ApplicationRecord
  has_many :appointments

  validates :first_name, :last_name, :email, presence: true
end
