class PurchasesController < ApplicationController
	before_action :set_purchase, only: [:show, :edit, :update, :destroy]
	before_action :set_purchase_details, only: [:show, :edit]
	before_action :set_providers, only: [:new, :edit]

	# Params for ordering dropdown
	ORDERS = [ "id DESC", "id ASC", "total DESC", "total ASC" ]

	def index
	    scope = Purchase.paginate(page: params[:page], per_page: params[:per_page])
	    if params[:search].present?
	      scope = scope.search(params[:search])
	    end
	    if params[:ordering] && ordering = ORDERS[params[:ordering].to_i]
	      scope = scope.order(ordering)
	    end
	    @purchases = scope.all.order('id DESC')
	    @purchases_qty = @purchases.count
	end

	def show
	end

	def new
		@purchase = Purchase.new
	end

	def edit
	end

	def create
		@purchase = Purchase.create(purchase_params.except!(:purchase_detail))
		PurchaseDetail.process_purchase_details(@purchase,purchase_params[:purchase_detail])
		respond_to do |format|
			if @purchase.save
				format.html { redirect_to @purchase, notice: 'Compra creada exitosamente.' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @purchase.update_attributes(purchase_params.except!(:purchase_detail))
				if purchase_params[:purchase_detail].present?
					PurchaseDetail.process_purchase_details(@purchase,purchase_params[:purchase_detail])
				end
				format.html { redirect_to @purchase, notice: 'Compra actualizada exitosamente.' }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@purchase.destroy
		respond_to do |format|
			format.html { redirect_to purchases_url, notice: 'Compra eliminada exitosamente.' }
		end
	end


	# METHOD TO DOWNLOAD VIA AXLSX GEM
	def download
	    @purchases = Purchase.all
	    render xlsx: "purchases.xlsx" 
	end

	private
		def set_purchase
			@purchase = Purchase.find(params[:id])
		end

	    def set_purchase_details
	      @purchase_details = PurchaseDetail.by_purchase_id(params[:id])
	    end

		def set_providers
			@providers = Provider.all.order('name ASC')
		end

	    def purchase_params
	      params.require(:purchase).permit(:provider_id, :subtotal, :tax, :total, :comment, :invoice, :invoice_image, purchase_detail: [:line, :name, :price])
	    end
end