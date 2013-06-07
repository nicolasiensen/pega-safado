class AddDateToRefund < ActiveRecord::Migration
  def change
    add_column :refunds, :date, :date
  end
end
