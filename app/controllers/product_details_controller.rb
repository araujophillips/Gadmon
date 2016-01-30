class ProductDetailsController < ApplicationController
  before_action :set_product_detail, only: [:show, :edit, :update, :destroy]
  before_action :set_product

  # GET /product_details
  # GET /product_details.json
  def index
    @product_details = ProductDetail.all
    puts "Hola"
  end

  # GET /product_details/1
  # GET /product_details/1.json
  def show
    puts "Chao"
  end

  # GET /product_details/new
  def new
    @product_detail = ProductDetail.new
  end

  # GET /product_details/1/edit
  def edit
  end

  # POST /product_details
  # POST /product_details.json
  def create
    @product_detail = ProductDetail.new(product_detail_params)
    @product_detail.product = @product
    respond_to do |format|
      if @product_detail.save
        format.html { redirect_to @product_detail.product, notice: 'Unidad agregada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /product_details/1
  # PATCH/PUT /product_details/1.json
  def update
    respond_to do |format|
      if @product_detail.update(product_detail_params)
        format.html { redirect_to @product_detail.product, notice: 'Unidad actualizada exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /product_details/1
  # DELETE /product_details/1.json
  def destroy
    @product_detail.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Unidad eliminada exitosamente.' }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_product_detail
      @product_detail = ProductDetail.find(params[:id])
    end

    def product_detail_params
      params.require(:product_detail).permit(:product_id, :serial, :status, :product_status, :comment)
    end
end
