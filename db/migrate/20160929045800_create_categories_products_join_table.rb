class CreateCategoriesProductsJoinTable < ActiveRecord::Migration[5.0]
  def change
	      create_join_table :categories, :products
  end
end
