class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :identification
      t.string :name
      t.string :last_name
      t.string :profile_picture
      t.boolean :activated, default: false
      t.integer :permission_level
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :identification, unique: true
    add_index :users, :email, unique: true
  end
end
