class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Response
  include ExceptionHandler

  def render_resource(resource)
    if resource.errors.empty?
      @user_response = resource.attributes
      json_response(@user_response, message = params[:controller].eql?('users/registrations') ? 'signed up successfully' : 'login successfully')
    else
      json_error_response(resource.errors, params[:controller].eql?('users/registrations') ? 'signup failed' :  'login failed', :bad_request)
    end
  end

  def authenticate_user!
    render json: {success: false, message: "need to sign in or sign up before continuing", status: 401} unless current_user.present?
    # render json: "need to sign in or sign up before continuing", status: 401
  end

end
