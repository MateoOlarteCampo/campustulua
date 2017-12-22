class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :picture
      t.references :user, foreign_key: true
      t.integer :visits_count, default: 0

      t.timestamps
    end
  end
end
