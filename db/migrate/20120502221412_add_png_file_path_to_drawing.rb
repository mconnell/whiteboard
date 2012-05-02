class AddPngFilePathToDrawing < ActiveRecord::Migration
  def change
    change_table :drawings do |t|
      t.string :png_file_path
    end
  end
end
