class RenameCaterogyIdToCategoryId < ActiveRecord::Migration[5.0]
  def change
	  rename_column :categories_categories, :caterogy_id, :category_id
  end
end
