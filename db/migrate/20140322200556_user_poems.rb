class UserPoems < ActiveRecord::Migration
  def change
    create_table :user_poems do |t|
      t.integer :user_id
      t.integer :poem_id
      t.integer :match_score
    end  
  end
end