class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :zipcode
      t.float   :latitude
      t.float   :longitude
      t.date    :birthday

      t.timestamps
    end
  end
end