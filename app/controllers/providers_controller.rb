class ProvidersController < ApplicationController
	before_action :set_provider, only: [:show, :edit, :destroy, :update]
	before_action :set_provider_types, only: [:show, :edit, :new]

	# Params for ordering dropdown
	ORDERS = [ "id DESC", "id ASC", "name ASC", "name DESC", "email ASC", "email DESC" ]

	# GET /providers
	def index
		scope = Provider
	    if params[:search].present?
	      scope = scope.search(params[:search])
	    end
	    if params[:ordering] && ordering = ORDERS[params[:ordering].to_i]
	      scope = scope.order(ordering)
	    end
		@providers = scope.all.order('id DESC')
	end

	# GET /providers/new
	def new
		@provider = Provider.new
	end

	# GET /providers/edit
	def edit
	end

	# GET /providers/show
	def show
		@purchases = Purchase.by_provider_id(params[:id])
	end

	# POST /providers
	def create
		@provider = Provider.new(provider_params)
		respond_to do |format|
		  if @provider.save
		    format.html { redirect_to @provider, notice: 'Proveedor registrado exitosamente.' }
		  else
		    format.html { render :new }
		  end
		end
	end

	# PATCH/PUT /customers/1
	# PATCH/PUT /customers/1.json
	def update
		respond_to do |format|
		  if @provider.update(provider_params)
		    format.html { redirect_to @provider, notice: 'Proveedor editado exitosamente.' }
		  else
		    format.html { render :edit }
		  end
		end
	end

	# DELETE /customers/1
	# DELETE /customers/1.json
	def destroy
		@provider.destroy
		respond_to do |format|
		  format.html { redirect_to providers_url, notice: 'Proveedor eliminado exitosamente.' }
		end
	end

	private
	    def set_provider
	      @provider = Provider.find(params[:id])
	    end

	    def set_provider_types
	    	@provider_types = ProviderType.all.order('name ASC')
	    end

		def provider_params
		  params.require(:provider).permit(:name, :type_id, :email, :phone, :address, :rif, :comment)
		end
end