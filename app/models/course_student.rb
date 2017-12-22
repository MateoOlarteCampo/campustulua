class CourseStudent < ApplicationRecord

  # class_name tell rails that course is a object from course class and that the foreing_key is this table to find that coruse is course_id
  belongs_to :course, :class_name => 'Course', foreign_key: "course_id"

  # class_name tell rails that student is a object from User class and that the foreing_key is this table to find that user is user_id
  belongs_to :student, :class_name => 'User', foreign_key: "user_id"
  
  validates :user_id, presence: true, :uniqueness => {:scope => :course_id}
  validates :course_id, presence: true

  def self.search(user_id, course_id)
    where("course_id = ? AND user_id = ?", course_id, user_id).first
  end
end
