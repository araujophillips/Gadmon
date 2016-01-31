class ShippingAddressesController < ApplicationController
  before_action :set_shipping_address, only: [:show, :edit, :update, :destroy]
  before_action :set_customer

  # GET /shipping_addresses
  # GET /shipping_addresses.json
  def index
    @shipping_addresses = ShippingAddress.all.order('id DESC')
  end

  # GET /shipping_addresses/1
  # GET /shipping_addresses/1.json
  def show
  end

  # GET /shipping_addresses/new
  def new
    @shipping_address = ShippingAddress.new
  end

  # GET /shipping_addresses/1/edit
  def edit
  end

  # POST /shipping_addresses
  # POST /shipping_addresses.json
  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer = @customer

    respond_to do |format|
      if @shipping_address.save
        format.html { redirect_to @shipping_address.customer, notice: 'Direccion de envio creada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /shipping_addresses/1
  # PATCH/PUT /shipping_addresses/1.json
  def update
    respond_to do |format|
      if @shipping_address.update(shipping_address_params)
        format.html { redirect_to @shipping_address.customer, notice: 'Direccion de envio actualizada exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /shipping_addresses/1
  # DELETE /shipping_addresses/1.json
  def destroy
    @shipping_address.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: 'Direccion de envio eliminada exitosamente.' }
    end
  end

  private
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_shipping_address
      @shipping_address = ShippingAddress.find(params[:id])
    end

    def shipping_address_params
      params.require(:shipping_address).permit(:customer_id, :office, :company, :address, :municipality, :city, :state, :comment)
    end
end
