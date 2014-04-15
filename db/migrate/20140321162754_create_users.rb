class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :location
      t.float   :latitude
      t.float   :longitude
      t.date    :birthday
      t.string  :twitter_handle
      t.string  :first_name

      t.timestamps
    end
  end
end