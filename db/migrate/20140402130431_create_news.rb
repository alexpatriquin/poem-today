class CreateNews < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :user_id
      t.string  :title

      t.timestamps
    end
  end
end