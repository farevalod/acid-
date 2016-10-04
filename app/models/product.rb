class Product < ApplicationRecord
	has_and_belongs_to_many :carts
	has_and_belongs_to_many :categories
	accepts_nested_attributes_for :categories

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
		row = Hash[[header, spreadsheet.row(i)].transpose]
		product = find_by_id(row["id"]) || new
		product.attributes = row.to_hash
		product.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
		  when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
		  when ".xls" then Roo::Excel.new(file.path)
		  when ".xlsx" then Roo::Excelx.new(file.path)
		  else raise "Archivo invalido: #{file.original_filename}"
	  end
	end

end
