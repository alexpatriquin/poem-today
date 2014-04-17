class CreatePageNumbers < ActiveRecord::Migration
  def change
    create_table :page_numbers do |t|
      t.integer :number
      t.timestamps
    end
  end
end
