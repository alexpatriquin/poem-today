class UserPoems < ActiveRecord::Migration
  def change
    create_table :user_poems do |t|
      t.integer :user_id
      t.integer :poem_id
      t.integer :match_score
      t.string  :keyword_text
      t.integer :keyword_frequency
      # t.array   :keyword_source
      # t.array   :keyword_match_type
    end  
  end
end