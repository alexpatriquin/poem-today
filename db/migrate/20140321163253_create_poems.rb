class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :poet
      t.string :poet_birthyear
      t.string :title
      t.string :first_line
      t.text   :content
      t.string :holiday
      t.string :isbn

      t.timestamps
    end
  end
end
