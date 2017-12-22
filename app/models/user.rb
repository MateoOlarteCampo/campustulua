class User < ApplicationRecord

  has_secure_password

  validates :identification, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true,  length: { minimum: 6 }, allow_nil: true
  validates :name, presence: true 
  validates :last_name, presence: true 

  # class_name tell rails that courses_like_teacher are objects from Course class and that the foreing_key of this class in that table is user_id
  has_many :courses_like_teacher, class_name: "Course",  foreign_key: "user_id"

  # courses_like_student are objects from Course class, but that relationship is througt the course_students table and in that table is used course attribute
  has_many :course_students
  has_many :courses_like_student, :through => :course_students, :source => :course
  has_many :articles
  has_many :comments


  mount_uploader :profile_picture, ProfiePictureUploader

  def self.search(search, type_user)
    #change ILIKE to deploy in heroku
    where("permission_level = ? AND (identification LIKE ? OR name LIKE ? OR last_name LIKE ? OR email LIKE ?)", type_user,  "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end 

  def calification(course)
     CourseStudent.search(self.id, course.id).calification
  end

  def self.current_courses_teacher(user)
    if Time.now.month <= 7
      user.courses_like_teacher.where("year = ? AND semester = 1 "  , Time.now.year)  
    else
      user.courses_like_teacher.where("year = ? AND semester = 2 "  , Time.now.year) 
    end
  end


  def self.current_courses_student(user)
    if Time.now.month <= 7
      user.courses_like_student.where("year = ? AND semester = 1 "  , Time.now.year)  
    else
      user.courses_like_student.where("year = ? AND semester = 2 "  , Time.now.year) 
    end
  end

  def average_per_semester
    self.courses_like_student.order('year DESC','semester DESC').group("year", "semester").select("year, semester, sum(calification) as calification_sum, count(calification) as calification_num") 
  end

  def courses_per(year,semester)
    self.courses_like_student.where("year = ? AND semester = ? "  , year, semester).group("name").sum("calification")
  end


end

