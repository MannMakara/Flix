class RemoveImageFileNameFromMovie < ActiveRecord::Migration
  def change
    remove_column :movies, :image_file_name, :string
  end
end
