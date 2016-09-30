class Cart < ApplicationRecord
	belongs_to :user
	has_and_belongs_to_many :products
	def cart_total
		total = 0
		products.each do |p|
			total += p.price
		end
		total
	end
end
