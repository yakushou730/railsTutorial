class WelcomeController < ApplicationController

	def index
    #Rails.logger.debug("----- log test -----")
    #HardWorkerJob.perform_later
	end

	#GET /welcome/say_hello
	def say

		# say.html.erb
	end

  def something
    #render :text => "<h3>AWESOME!!! #{Time.now}</h3>"
    respond_to do |format|
      format.html {
        render :text => "<h3>AWESOME!!! #{Time.now}</h3>"
      }
      format.js
    end
  end

end
