class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # Params for filtering dropdown
  FILTER = [ "id DESC", "id ASC", "name ASC", "name DESC" ]

  # GET /products
  # GET /products.json
  def index
    scope = Product.paginate(page: params[:page], per_page: params[:per_page])
    if params[:search]
      scope = scope.search(params[:search])
    end
    if params[:filtering] && filtering = FILTER[params[:filtering].to_i]
      scope = scope.order(filtering)
    end
    @products = scope.overview
    @products_qty = @products.to_a.count
  end

  # GET /products/1
  # GET /products/1.json
  def show
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
        format.html { redirect_to @product, notice: 'Producto creado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Producto editado exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Producto eliminado exitosamente.' }
    end
  end

  # METHOD TO DOWNLOAD VIA AXLSX GEM
  def download
      @products = Product.overview
      render xlsx: "products.xlsx" 
  end

  private
    def set_product
      @product = Product.find(params[:id])
      @product_details = @product.product_details.paginate(page: params[:inventory_page], per_page: 10)
      @prices = @product.prices.paginate(page: params[:prices_page], per_page: 5)
    end

    def product_params
      params.require(:product).permit(:name, :published, prices_attributes: [ :id, :product_id, :price, :comment ])
    end
end