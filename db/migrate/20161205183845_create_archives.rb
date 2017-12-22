class CreateArchives < ActiveRecord::Migration[5.0]
  def change
    create_table :archives do |t|
      t.string :name
      t.text :description
      t.string :file 
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
