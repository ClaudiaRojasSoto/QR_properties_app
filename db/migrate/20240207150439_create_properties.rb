class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :qr_code_url

      t.timestamps
    end
  end
end
