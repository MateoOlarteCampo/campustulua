class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :matriculate_students, :add_calification]
  before_action :autenticathe_login!
  before_action :autenticathe_admin!, except: [:index, :show, :matriculate_students, :add_calification]
  before_action only: [:matriculate_students, :add_calification] do
    autenticathe_teacher!(@course)
  end
  before_action :autenticathe_date!, only: [:edit, :update, :matriculate_students, :add_calification]


  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all if is_admin_user?(current_user)
    @courses = current_user.courses_like_teacher if is_teacher_user?(current_user)
    @courses = current_user.courses_like_student if is_student_user?(current_user)

  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @archive = Archive.new
  end

  # GET /articles/new
  def new
    @course = Course.new
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    unless ( params[:students].blank? ) 
      @course.students_ids = params[:students]
    end
     respond_to do |format|
      if @course.save
        flash[:success] = "Curso creado exitosamente."
        format.html { redirect_to @course}
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /courses/1/edit
  def edit
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    unless ( params[:students].blank? ) 
      @course.students_ids = params[:students]
    end
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course}
        format.json { render :show, status: :ok, location: @course}
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def matriculate_students
    unless ( params[:students].blank? ) 
      @course.students_ids = params[:students]
      @course.save_course_students
      redirect_to @course
    end
  end

  def add_calification
    courseStudent = CourseStudent.search(params[:user_id], params[:id])
    respond_to do |format|
      if courseStudent.update_attribute(:calification, params[:calification])
        format.json { render json: courseStudent}
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      flash[:danger] = "Curso eliminado exitosamente."
      format.html { redirect_to courses_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :semester, :year, :user_id)
    end

end
