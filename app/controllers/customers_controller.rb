class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # Params for ordering dropdown
  ORDERS = [ "id DESC", "id ASC", "name ASC", "name DESC", "email ASC", "email DESC", "username ASC", "username DESC" ]

  # GET /customers
  # GET /customers.json
  def index
    if params[:per_page].nil?
      params[:per_page] = 20
    end
    scope = Customer.paginate(page: params[:page], per_page: params[:per_page])
    if params[:search].present?
      scope = scope.search(params[:search])
    end
    if params[:ordering] && ordering = ORDERS[params[:ordering].to_i]
      scope = scope.order(ordering)
    end
    @customers = scope.all.order('id DESC')
    @customers_qty = @customers.count
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @orders = Order.paginate(page: params[:orders_page], per_page: 5).with_current_status().by_customer_id(params[:id])
    @shipping_address = ShippingAddress.new
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Cliente registrado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Cliente editado exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Cliente eliminado exitosamente.' }
    end
  end

  # METHOD TO DOWNLOAD VIA AXLSX GEM
  def download
      @customers = Customer.all
      render xlsx: "customers.xlsx" 
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
      @shipping_addresses = @customer.shipping_addresses.paginate(page: params[:addresses_page], per_page: 5)
    end

    def customer_params
      params.require(:customer).permit(:name, :email, :phone, :username, :comment)
    end
end
