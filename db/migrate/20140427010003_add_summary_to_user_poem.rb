class AddSummaryToUserPoem < ActiveRecord::Migration
  def change
    add_column :user_poems, :summary, :string
  end
end
