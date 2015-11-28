class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # Params for ordering dropdown
  ORDERS = [ "id DESC", "id ASC", "name ASC", "name DESC" ]

  # GET /products
  # GET /products.json
  def index
    scope = Product
    if params[:search]
      scope = scope.search(params[:search])
    end
    if params[:ordering] && ordering = ORDERS[params[:ordering].to_i]
      scope = scope.order(ordering)
    end
    @products = scope.includes(:current_price).all.stock.order('id DESC')
    @product_detail = ProductDetail.new
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @price = Price.new
    @product_detail = ProductDetail.new
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.prices.build
  end

  # GET /products/1/edit
  def edit
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
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:product).permit(:name, :published, prices_attributes: [ :id, :product_id, :price, :comment ])
    end

end
