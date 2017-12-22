class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # Confirms a logged-in user.
  def autenticathe_login!
    unless someone_is_logged_in?
      store_location
      flash[:danger] = "Por favor, Inicie sesion."
      redirect_to welcome_path
    end
  end

  # Confirms the correct user.
  def autenticathe_user!(user)
    redirect_to(root_url) unless current_user?(user)
  end

  # Confirms an admin user.
  def autenticathe_admin!
    unless someone_is_logged_in? && is_admin_user?(current_user)
      redirect_to root_path
    end
  end

  # Confirms an admin user.
  def autenticathe_teacher!(course)
    unless someone_is_logged_in? && is_teacher_user?(current_user) && current_user?(course.teacher)
      redirect_to root_path
    end
  end

  def autenticathe_date! 
    unless @course.validate_date?
      flash[:danger] = "Ya no se puede modificar el curso"
      redirect_to @course
    end
  end

end
