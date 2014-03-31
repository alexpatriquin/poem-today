class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :name

      t.timestamps
    end
  end
end
