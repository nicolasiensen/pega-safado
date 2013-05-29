class AddUidToDeputy < ActiveRecord::Migration
  def change
    add_column :deputies, :uid, :integer
  end
end
