class Cart < ApplicationRecord
	belongs_to :user
	has_and_belongs_to_many :products
	def cart_total
		products.sum{|p| p.price}
	end
end
