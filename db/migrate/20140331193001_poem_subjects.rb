class PoemSubjects < ActiveRecord::Migration
  def change
    create_table :poem_subjects do |t|
      t.integer :poem_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
