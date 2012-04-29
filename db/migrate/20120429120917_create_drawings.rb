class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.belongs_to :user
      t.text :data

      t.timestamps
    end
  end
end
