class HomeController < ApplicationController
	before_action :autenticathe_login_home!
	
	def show
		@users = User.where(:activated => false).paginate(page: params[:page], per_page: 4) if is_admin_user?(current_user)
		@articles = Article.where.not(picture: "NULL").order('created_at DESC').limit(5) if is_teacher_user?(current_user) or is_student_user?(current_user)
		@courses = User.current_courses_teacher(current_user) if is_teacher_user?(current_user)
		@courses = User.current_courses_student(current_user) if is_student_user?(current_user)
			
		
	end

	private
		 # Confirms a logged-in user.
	  def autenticathe_login_home!
	    unless someone_is_logged_in?
	      store_location
	      redirect_to welcome_path
	    end
	  end
end
