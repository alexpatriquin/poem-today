class AddImageToPoem < ActiveRecord::Migration
  def change
    add_column :poems, :image_url, :string
  end
end
