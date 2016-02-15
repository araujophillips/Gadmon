class PurchaseDetail < ActiveRecord::Base
	belongs_to :purchase, foreign_key: :purchase_id

    def self.process_purchase_details(purchase, purchase_details_params)
        purchase_details_params.each do |purchase_details_param|
            if PurchaseDetail.exists?(:purchase_id => purchase.id, :line => purchase_details_param["line"])

            else
                purchase_details_param["purchase_id"] = purchase.id
                @purchase_detail = PurchaseDetail.create(purchase_details_param)
            end
        end

        @purchase_details = PurchaseDetail.by_purchase_id(purchase.id)

        puts 'PARAMETROS:'
        puts purchase_details_params.to_json
        puts "BDD:"
        puts @purchase_details.to_json
        puts 'BDD Lineas:'


        @purchase_details.each do |purchase_detail|
            line = purchase_detail.line.to_s

            if purchase_details_params.any? { |detail| detail['line'].include?(line) } == false
                PurchaseDetail.where(:purchase_id => purchase.id, :line => line).destroy_all
            end
        end

    end

	def self.by_purchase_id(purchase_id)
		where("purchase_id = ?", purchase_id)
	end

end
