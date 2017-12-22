class WelcomeController < ApplicationController

	before_action :logged_in_user_not

	def show 
		@user = User.new
	end
	
	private 
	
		def logged_in_user_not
	      unless !someone_is_logged_in?
	        redirect_to root_path
	      end
		end
end