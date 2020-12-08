class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # A particular user may register 0 or more vehicles.
  # But these should be removed if the user is unregistered from the site.
  has_many :vehicles, dependent: :destroy
end
