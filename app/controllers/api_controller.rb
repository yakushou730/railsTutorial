class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!

    if params[:auth_token].present?

      user = User.find_by_authentication_token( params[:auth_token] )

      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    #else
      #render :json => { :message => "authenticate user token fail" }, :status => 401
    end
  end

end
