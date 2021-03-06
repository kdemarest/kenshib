
class SessionsController < ApplicationController
  def new
  end

	def create
#		logger.debug "KD: in session controller"
#	    render :text => "KD: in session controller"

	  auth_hash = request.env['omniauth.auth']
	  if session[:user_id]
	    # Means our user is signed in. Add the authorization to the user
	    User.find(session[:user_id]).add_provider(auth_hash)

	    s = "Successful login via #{auth_hash["provider"].capitalize}<br />"
	    s += "env vars:<br />"
	    ENV.each_pair do |k,v|
			s += "env['"+k+"'] = '"+v+"'<br />"
		end

	    render :text => s
	  else
	    # Log him in or sign him up
	    auth = Authorization.find_or_create(auth_hash)
	    # Create the session
	    session[:user_id] = auth.user.id
	    render :text => "Welcome #{auth.user.name}!"
	  end
	end

	def failure
		render :text => "Sorry, but you didn't allow access to our app!"
	end
	
	def ken
		logger.debug "KD: ken"
		render :text => "ken"
	end
	
	def destroy
		session[:user_id] = nil
		render :text => "You've logged out!"
	end
end
