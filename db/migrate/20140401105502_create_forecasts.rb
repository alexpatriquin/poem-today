class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :user_id
      t.string  :summary
      t.integer :min_temp
      t.integer :max_temp

      t.timestamps
    end
  end
end
