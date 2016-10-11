class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy, :add, :remove]

	# GET /products
	# GET /products.json
	def index
		@products = Product.all
		if current_user.nil?
			new_user = User.new(email: "guest"+rand(1024).to_s+"@guest-domain.com", password: rand(36**8).to_s(36))
			new_user.save
			sign_in(new_user)
			@cart = Cart.new
			new_user.carts << @cart
			@cart.save
		else
			@cart = current_user.cart
		end
	end

	# POST /products/1/add
	# POST /products/1/add.json
	def add
		@cart = current_user.cart
		@cart.products << @product
		redirect_to products_url
	end

	def remove
		@cart = current_user.cart
		@cart.products.delete(@product)
		redirect_to current_user.cart
	end
	#
	# GET /products/1
	# GET /products/1.json
	def show
	end

	# GET /products/new
	def new
		@product = Product.new
	end

	# GET /products/1/edit
	def edit
		@categories = Category.all
	end

	# POST /products
	# POST /products.json
	def create
		@product = Product.new(product_params)

		respond_to do |format|
			if @product.save
				format.html { redirect_to @product, notice: 'Product was successfully created.' }
				format.json { render :show, status: :created, location: @product }
			else
				format.html { render :new }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /products/1
	# PATCH/PUT /products/1.json
	def update
		respond_to do |format|
			p product_params
			if @product.update(product_params)
				format.html { redirect_to @product, notice: 'Product was successfully updated.' }
				format.json { render :show, status: :ok, location: @product }
			else
				format.html { render :edit }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def import
		Product.import(params[:file])
		redirect_to root_url, notice: "Productos importados."
	end

	# DELETE /products/1
	# DELETE /products/1.json
	def destroy
		@product.destroy
		respond_to do |format|
			format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_product
		@product = Product.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def product_params
		params.require(:product).permit(:name, :price, :description, category_ids: [])
	end
end
