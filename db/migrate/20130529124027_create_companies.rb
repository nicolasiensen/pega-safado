class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :cnpj
      t.string :name

      t.timestamps
    end
  end
end
