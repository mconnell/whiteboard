class CreateWhiteboards < ActiveRecord::Migration
  def change
    create_table :whiteboards do |t|
      t.belongs_to :user
      t.text       :data, :default => "[]"
      t.string     :png_file_path

      t.timestamps
    end
  end
end
