module ApplicationHelper
	
	def auth_fragment
		user_signed_in? ? link_to("Log off", destroy_user_session_path,  method: :delete, data: { confirm: 'Are you sure?' } ) : link_to("Log in", new_user_session_path)
	end
	
end
