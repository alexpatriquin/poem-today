class UserPoems < ActiveRecord::Migration
  def change
    create_table :user_poems do |t|
      t.integer  :user_id
      t.integer  :poem_id
      t.integer  :match_score
      t.string   :keyword_text
      t.integer  :keyword_frequency
      t.string   :keyword_source
      t.string   :match_type
    end  
  end
end