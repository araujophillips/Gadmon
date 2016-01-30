class OrderDetail < ActiveRecord::Base
	belongs_to :order, foreign_key: :order_id
	belongs_to :product, foreign_key: :product_id
	belongs_to :product_detail, foreign_key: :product_detail_id
	belongs_to :price

	before_destroy :set_detail_as_available

	def self.by_order_id(order_id)
		where("order_id = ?", order_id)
	end

  def self.process_order_details(order, order_details_params)
    order_details_params.each do |order_details_param|

      if OrderDetail.exists?(:product_detail_id => order_details_param["product_detail_id"])
        
        OrderDetail.where("order_id = ?", order.id)
                   .where("product_detail_id = ?", order_details_param["product_detail_id"])
                   .update_all(:comission => order_details_param["comission"])

        product_detail_id = order_details_param["product_detail_id"]
      elsif
        order_details_param["order_id"] = order.id
        @order_detail = OrderDetail.create(order_details_param)
        product_detail_id = @order_detail.product_detail_id
      end

      product_detail = ProductDetail.find(product_detail_id)
      product_detail.update_attributes(:status => "2")
    end

    @order_details = OrderDetail.by_order_id(order.id)

    @order_details.each do |order_detail|
      product_detail_id = order_detail.product_detail_id.to_s
      if order_details_params.any? { |detail| detail['product_detail_id'].include?(product_detail_id) } == false
        OrderDetail.where(:product_detail_id => product_detail_id).destroy_all
      end
    end

  end

  def set_detail_as_available
    order_details = order.order_details
    order_details.each do |order_detail|
      ProductDetail.update(order_detail.product_detail_id, :status => 1)
    end
  end

end