class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :zipcode

      t.timestamps
    end
  end
end
