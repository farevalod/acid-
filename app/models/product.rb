class Product < ApplicationRecord
	has_and_belongs_to_many :carts
	has_and_belongs_to_many :categories
	accepts_nested_attributes_for :categories
end
