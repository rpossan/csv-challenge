class VisitorsController < ApplicationController
	
	def index
  		redirect_to profiles_path if user_signed_in?
	end
	
end
