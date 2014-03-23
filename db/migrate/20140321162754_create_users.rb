class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :zipcode
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end