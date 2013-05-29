class AddStateToDeputy < ActiveRecord::Migration
  def change
    add_column :deputies, :state, :string
  end
end
