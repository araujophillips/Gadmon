class ChangeColumnName < ActiveRecord::Migration
	def change
		rename_column :providers, :type, :type_id
	end
end
