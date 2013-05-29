class AddCategoryIdToRefund < ActiveRecord::Migration
  def change
    add_column :refunds, :category_id, :integer
  end
end
