class CreateProductStatuses < ActiveRecord::Migration
  def change
    create_table :product_statuses do |t|
      t.boolean :available
      t.string :name

      t.timestamps null: false
    end
  end
end
