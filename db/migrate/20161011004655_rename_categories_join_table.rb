class RenameCategoriesJoinTable < ActiveRecord::Migration[5.0]
  def change
	rename_table "categories_caterogies", "categories_categories"
  end
end
