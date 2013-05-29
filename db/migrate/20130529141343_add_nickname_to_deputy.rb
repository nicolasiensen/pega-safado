class AddNicknameToDeputy < ActiveRecord::Migration
  def change
    add_column :deputies, :nickname, :string
  end
end
