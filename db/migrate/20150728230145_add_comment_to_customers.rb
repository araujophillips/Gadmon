class AddCommentToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :comment, :string
  end
end
