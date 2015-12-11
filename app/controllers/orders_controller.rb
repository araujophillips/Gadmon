class OrdersController < ApplicationController

  # GET /orders/update_quantiy
  def update_quantity
    @product = Product.by_id(params[:id])
    product_details = ProductDetail.by_id(params[:id])
    respond_to do |format|
      format.json { render :json => @product.to_json( { :include => [ :current_price, :product_details ] } ) }
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.by_order_id(params[:id])
    @customer = Customer.find(@order.customer_id)
  end

  # GET /orders/new
  def new
    @order = Order.new
    @customers = Customer.all.order('name ASC')
    @products = Product.only_with_stock.order('name ASC')
    @product_details = ProductDetail.all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    # Creates the order removing the order details from the hash
    @order = Order.create(order_params.except!(:order_detail))

    # Set all the details into an empty array
    order_details_attributes = order_params[:order_detail]

    puts order_params[:order_detail]

    order_details_attributes.each do |order_detail_attributes|

      # Fill the params with order_id and creates the detail
      order_detail_attributes["order_id"] = @order.id
      @order_detail = OrderDetail.create(order_detail_attributes)

      # Update the product detail as sold
      product_detail = ProductDetail.find(@order_detail.product_detail_id)
      product_detail.update_attributes(:status => "2")

    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :subtotal, :tax, :comission, :total, :invoice, :shipping_id, order_detail: [:product_id, :product_detail_id, :price_id, :comission])
    end

end
