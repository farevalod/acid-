class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :carts

  def cart
	  @cart = self.carts.last
	  if @cart.nil?
		@cart = Cart.new
		self.carts << @cart
	  end
	  @cart
  end
end
