class CreateCartsProductsJoinTable < ActiveRecord::Migration[5.0]
  def change
	      create_join_table :carts, :products
  end
end
