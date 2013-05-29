class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.integer :company_id
      t.integer :deputy_id
      t.string :invoice
      t.float :value

      t.timestamps
    end
  end
end
