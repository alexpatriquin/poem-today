class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.string  :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
