class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :carts

  def cart
	  @cart = self.carts.last
	  if @cart.nil?
		self.carts << Cart.new
		@cart = self.carts.last
	  end
  end
end
