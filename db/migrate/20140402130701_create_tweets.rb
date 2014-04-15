class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :text
      t.string :id_str

      t.timestamps
    end
  end
end
