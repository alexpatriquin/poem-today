class CreateUserOccasions < ActiveRecord::Migration
  def change
    create_table :user_occasions do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
