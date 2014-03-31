class CreatePoemOccasions < ActiveRecord::Migration
  def change
    create_table :poem_occasions do |t|
      t.integer :poem_id
      t.integer :occasion_id

      t.timestamps
    end
  end
end
