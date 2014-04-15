class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.date    :birthday
      t.string  :twitter_handle
      t.string  :location
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end