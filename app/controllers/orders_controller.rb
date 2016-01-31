class OrdersController < ApplicationController
  before_action :set_customers, only: [:edit, :new]
  before_action :set_order_details, only: [:edit, :show]
  before_action :set_products, only: [:edit, :show, :new]
  before_action :set_order, only: [:edit, :show, :destroy]
  before_action :set_order_status_details, only: [:edit, :show]

  # Params for ordering dropdown
  ORDERS = [ "id DESC", "id ASC" ]

  # GET /orders/update_quantity
  def update_quantity
    @product = Product.by_id(params[:product_id])
    response = @product.to_json( { :include => [ :current_price ], :methods => [ :product_details_availables ] } )
    respond_to do |format|
      format.json { render :json => response}
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    scope = Order
    if params[:search].present?
      scope = scope.search(params[:search])
    end
    if params[:ordering] && ordering = ORDERS[params[:ordering].to_i]
      scope = scope.order(ordering)
    end
    @orders = scope.with_current_status()
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @customer = Customer.find(@order.customer_id)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order_statuses = OrderStatus.all.order('id ASC')
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.create(order_params.except!(:order_detail))
    @order_status_detail = OrderStatusDetail.create(:status_id => 1, :order_id => @order.id)
    OrderDetail.process_order_details(@order,order_params[:order_detail])
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Orden creada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update_attributes(order_params.except!(:order_detail))
        if order_params[:order_detail].present?
          OrderDetail.process_order_details(@order,order_params[:order_detail])
        end
        OrderStatusDetail.change_order_status(@order)
        format.html { redirect_to @order, notice: 'Orden actualizada exitosamente.' }
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
      format.html { redirect_to orders_url, notice: 'Orden eliminada exitosamente.' }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def set_order_details
      @order_details = OrderDetail.joins(:product).by_order_id(params[:id])
    end

    def set_customers
      @customers = Customer.all.order('name ASC')
    end

    def set_products
      @products = Product.only_with_stock.order('name ASC')
      @product_details = ProductDetail.all
    end

    def set_order_status_details
      @order_status_details = OrderStatusDetail.where('order_id = ?', @order.id)
    end

    def order_params
      params.require(:order).permit(:customer_id, :subtotal, :tax, :comission, :total, :invoice, :shipping_id, order_detail: [:product_id, :product_detail_id, :price_id, :comission])
    end
end