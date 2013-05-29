class CreateDeputies < ActiveRecord::Migration
  def change
    create_table :deputies do |t|
      t.string :name
      t.integer :party_id

      t.timestamps
    end
  end
end
