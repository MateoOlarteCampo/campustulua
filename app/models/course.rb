class Course < ApplicationRecord

   # class_name tell rails that teacher is a object from User class and that the foreing_key is this table to find that user is user_id
  belongs_to :teacher, class_name: "User", foreign_key: "user_id"

  # students are objects the User class, but that relationship is througt the course_students table and in that table is used student attribute
  has_many :course_students, dependent: :destroy
  has_many :students, through: :course_students, source: :student

  has_many :archives

  validates :name, presence: true, uniqueness: true
  validates :year, presence: true
	validates :semester, presence: true
	validates :teacher, presence: true

  after_create :save_course_students
  after_update :save_course_students


  def students_ids=(students)
    @students_ids = students
  end

  def save_course_students
    @students_ids.each do |student_id|
      CourseStudent.create(user_id: student_id, course_id: self.id)
    end
  end

  def course_student?(user)
    self.students.each do |student|
      if user==student
        return true
      end
    end
    
    return false
  end

  def validate_date?
    validation = true
    date = Time.now
    if date.year > self.year or date.year < self.year
      validation =  false
    else
      if self.semester==1
        if date.month >= 8 
          validation =  false
        end
      else
        if date.month < 8 
          validation =  false
        end
      end
    end
    validation
  end



end
