class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.integer :type
      t.string :email
      t.string :phone
      t.string :address
      t.string :rif
      t.string :comment

      t.timestamps null: false
    end
  end
end
