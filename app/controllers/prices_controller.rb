class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  before_action :set_product

  # GET /prices
  # GET /prices.json
  def index
    @prices = Price.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = Price.new
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = Price.new(price_params)
    @price.product = @product
    respond_to do |format|
      if @price.save
        format.html { redirect_to @price.product, notice: 'Price was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to @price.product, notice: 'Price was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to prices_url, notice: 'Price was successfully destroyed.' }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_price
      @price = Price.find(params[:id])
    end

    def price_params
      params.require(:price).permit(:product_id, :price)
    end
end
