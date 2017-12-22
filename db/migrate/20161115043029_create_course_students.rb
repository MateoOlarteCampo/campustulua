class CreateCourseStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :course_students do |t|
      t.decimal :calification, :precision => 16, :scale => 2, default: 0.0
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
